#! /usr/bin/perl

use strict;
use warnings;

use constant
    HOME_SRC => qw|github/fusioninventory/fusioninventory-agent/bin|;

use Digest::SHA1 qw(sha1);
use File::Copy;

my ($destination) = __FILE__ =~ m{(.*)/[^/]*\.pl$}
    or die "Can't set destination folder from this script: $!\n";

print "Destination folder: $destination\n";

my $total = 0;
my $count = 0;

my @files = grep { /\.md$/ && -e $_ } map { "$destination/$_" } @ARGV;
@files = grep { -e $_ } map { s|.*/|| ; "$destination/$_.md" } @ARGV
    unless @files;
@files = <$destination/*.md> unless @files;

for my $file (@files) {

    next if $file =~ /agent.cfg.md/ || $file =~ /index.md/;

    $total ++;

    print "----\nDestination file: $file\n";

    my ($source) = $file =~ m{.*/(.*)\.md$}
        or next;

    print "Looking for $source source...\n";

    # Found source to read pod from few default places
    my ($full_src_path) = grep { -e $_ } (
        $source,
        "bin/$source",
        $ENV{HOME} . "/" . HOME_SRC . "/" . $source,
        grep { -d $_ } @ARGV
    ); 

    # Try from PATH if executable
    if (!$full_src_path) {
        $full_src_path = qx|which $source 2>/dev/null|;
        chomp($full_src_path);
    }

    unless ($full_src_path) {
        warn "WARN !!! No source found for: $source\n";
        next;
    }

    my $html;
    my $gen = FusionInventory::Pod::Simple::Markdown->new;
    $gen->output_string(\$html);

    print "Reading POD from $full_src_path source...\n";
    $gen->parse_file($full_src_path);

    if ($html) {
        print "Generating $file ...\n";

        if ( -e $file ) {
            my $sha1 = Digest::SHA1->new();
            open CURRENT, $file
                or die "Can't open current file: $!";
            my $cur_sha1 = $sha1->addfile(*CURRENT)->digest
                or die "Can't compute old file digest\n";
            close(CURRENT);
            my $new_sha1 = sha1($html)
                or die "Can't compute new file digest\n";
            if ($cur_sha1 eq $new_sha1) {
                print "No change found, skipping\n";
                next;
            }
        }

        open INC, ">", $file
            or die "Can't open destination file: $!\n";
        print INC $html;
        close(INC);

        $count ++;

    } else {
        warn "WARN !!! No HTML code generated\n";
    }
}

print "----\n";
print "Checked $total file".($total>1?"s":"")."\n";
die "No file generated\n" unless $count;
print "$count file".($count>1?"s":"")." generated.\n";

exit(0);

#
# Pod::Simple::HTML is not perfect for our purpose, so we need to tune it for
# Github pages
#
package FusionInventory::Pod::Simple::Markdown;

use parent qw{Pod::Simple::HTML};

use File::stat;

sub new {
    my $self = shift->SUPER::new(@_);

    # Replace html header py markdown templating, resetting CSS before content
    # to avoid indexing headers at used levels
    $self->top_anchor("");
    $self->html_header_before_title("---\nlayout: single\ntitle: ");
    $self->html_header_after_title("
---
<style>
.post-content h2 { font-weight: bold ; margin: 1.5rem 0; }
.post-content h1:before { content: ''; }
.post-content h2:before { content: ''; }
.post-content h3:before { content: ''; }
</style>
<!-- begin man -->
");

    # Use markdown syntax for headers
    for my $head (1..4) {
        $self->{Tagmap}->{"head$head"}  = "\n". "#" x $head . " ";
        $self->{Tagmap}->{"/head$head"} = "\n";
    }

    $self->{Tagmap}->{"F"} = "_**";
    $self->{Tagmap}->{"/F"} = "**_";
    $self->{Tagmap}->{"B"} = "**";
    $self->{Tagmap}->{"/B"} = "**";
    $self->{Tagmap}->{"I"} = "_";
    $self->{Tagmap}->{"/I"} = "_";
    $self->{Tagmap}->{"L"} = "[";
    $self->{Tagmap}->{"/L"} = ")";
    $self->{Tagmap}->{"item-text"} = "\n### ";
    $self->{Tagmap}->{"/item-text"} = "\n";
    $self->{Tagmap}->{"item-body"} = "";
    $self->{Tagmap}->{"/item-body"} = "\n";
    $self->{Tagmap}->{"item-bullet"} = "* ";
    $self->{Tagmap}->{"/item-bullet"} = "\n";
    $self->{Tagmap}->{"item-number"} = "1. ";
    $self->{Tagmap}->{"/item-number"} = "\n";
    $self->{Tagmap}->{"over-text"} = "";
    $self->{Tagmap}->{"/over-text"} = "\n";
    $self->{Tagmap}->{"over-bullet"} = "";
    $self->{Tagmap}->{"/over-bullet"} = "\n";
    $self->{Tagmap}->{"over-number"} = "";
    $self->{Tagmap}->{"/over-number"} = "\n";
    $self->{Tagmap}->{"Para"} = "\n";
    $self->{Tagmap}->{"/Para"} = "\n\n";

    return $self;
}

sub parse_file {
    my($self, $source) = (@_);

    my $stat = stat($source);
    my $date = scalar localtime $stat->mtime;

    $self->html_footer("
<em class='post-meta'>Last source update: $date</em>
<!-- end man -->
");

    return $self->SUPER::parse_file($source);
}

# Hacked do_middle to fix few formatting issues
sub do_middle {
    my ($self) = shift;
    my $fh = $self->{'output_fh'};
    my $tagmap = $self->{'Tagmap'};

    my($token, $type, $tagname, $linkto, $linktype, $synopsis);
    my @stack;
    my $dont_wrap = 0;

    while($token = $self->get_token) {

        if( ($type = $token->type) eq 'start' ) {
            if(($tagname = $token->tagname) eq 'L') {
                $linktype = $token->attr('type') || 'insane';

                $linkto = $self->do_link($token);

                if(defined $linkto and length $linkto) {
                    $self->esc($linkto);
                    print $fh $tagmap->{$tagname};
                }

            } elsif ($tagname eq 'item-text' or $tagname =~ m/^head\d$/s) {
                print $fh $tagmap->{$tagname} || next;

                my @to_unget;
                while(1) {
                    push @to_unget, $self->get_token;
                    last if $to_unget[-1]->is_end
                        and $to_unget[-1]->tagname eq $tagname;
                }

                my $name = $self->linearize_tokens(@to_unget);
                $name = $self->do_section($name, $token) if defined $name;

                $self->unget_token(@to_unget);

            } else {
                if( $tagname =~ m/^over-/s ) {
                    push @stack, '';
                } elsif( $tagname =~ m/^item-/s and @stack and $stack[-1] ) {
                    print $fh $stack[-1];
                    $stack[-1] = '';
                }
                if (!$synopsis) {
                    print $fh $tagmap->{$tagname} || next;
                }
                ++$dont_wrap if $tagname eq 'Verbatim' or $tagname eq "VerbatimFormatted"
                    or $tagname eq 'X';
                $synopsis = 0 if $tagname eq 'VerbatimFormatted';
            }

        } elsif( $type eq 'end' ) {
            if( ($tagname = $token->tagname) =~ m/^over-/s ) {
                if( my $end = pop @stack ) {
                    print $fh $end;
                }
            } elsif( $tagname =~ m/^item-/s and @stack) {
                $stack[-1] = $tagmap->{"/$tagname"};
                if( $tagname eq 'item-text' and defined(my $next = $self->get_token) ) {
                    $self->unget_token($next);
                    if( $next->type eq 'start' ) {
                        print $fh $tagmap->{"/item-text"},$tagmap->{"item-body"};
                        $stack[-1] = $tagmap->{"/item-body"};
                    }
                }
                next;
            }
            print $fh $tagmap->{"/$tagname"} || next;
            --$dont_wrap if $tagname eq 'Verbatim' or $tagname eq 'X';

        } elsif( $type eq 'text' ) {
            $self->esc($type = $token->text);  # reuse $type, why not
            if ($tagname eq 'head1' && $token->text eq "SYNOPSIS") {
                $synopsis = 1;
            } elsif ($synopsis) {
                print $fh $tagmap->{"VerbatimFormatted"};
            } else {
                $type =~ s/([\?\!\"\'\.\,]) /$1\n/g unless $dont_wrap;
                $type =~ s/--/\\--/g unless ($tagname eq 'Verbatim' || $tagname eq "VerbatimFormatted");
            }
            print $fh $type;
            if ($tagname eq 'L' && $linkto) {
                print $fh "]($linkto";
                undef $linkto;
            }
        }

    }
    return 1;
}
