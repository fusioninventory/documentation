---
layout: single
title: Release process
---

# Prepare release branch with git-flow

    git flow release start 2.4.2

# Changes list validation

Ensures the Changes file contains references to all majors changes since latest release, with references to all resolved bugs.

Fix the date of the release in the Changes file. The date can be generated with the following command:

    LANG=C date +"%a, %d %b %Y"

The changelog section entry must start with a line in the following format:

    2.4.2  Tue, 02 Oct 2018

* version
* 2 spaces
* LANG=C date +"%a, %d %b %Y"

# Bump versions

Bump all necessary versions and report the bumps in Changes if not done yet

# Update IDS databases

    ./tools/updatePciids.pl # For the agent
    ./tools/updateUsbids.pl
    cp ../sysobject.ids/sysobject.ids share

Also update the Changes accordingly

# Test suite validation

Ensures the full test suite, with developper tests enabled, executes correctly on at least linux & windows platforms:

    make test TEST_AUTHOR=1

# Finish release with git-glow

    git flow release finish 2.4.2

# Publish release on github

Push master branch, tag & develop branch to github:

    git checkout master
    git push
    git push --tags
    git checkout develop
    git push

# Tarball creation

Cleanup the local repository, including MANIFEST file:

    rm MANIFEST
    perl Makefile.PL
    make reset

Generate the package after generating the MANIFEST file and a last distribution test:

    perl Makefile.PL
    make manifest
    make disttest
    make dist

# Tarball upload

Tarball has to be uploaded on the forge and on CPAN.

# Mark bugs as closed

Go on the [github issues](https://github.com/fusioninventory/fusioninventory-agent/issues) and change the status of any still not closed issue but fixed by this release.

# Release announcement

Publish official announcement:

* [Get the wiki source]({{ site.baseurl }}/documentation/wiki.html)
* Go in fusioninventory.github.io directory
* Create a release post in _posts folder
* Create posts on the [forum](http://forum.fusioininventory.org/)

At the end the process this should be done:

* as a post to the user mailing-list
* as a news on the websites

# Bugtracker update

Move open issues to next planned version if you still believe they will be fixed in a timely fashion. Otherwise you should unset the “planned version” field of the issues.
