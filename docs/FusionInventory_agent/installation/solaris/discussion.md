# Solaris agent - OpenCSW

OpenCSW (Solaris agent) package does not work any more for fusioninventory_agent  .. please, can you check this out.

I already use OpenCSW on my solaris_x86 servers (mostly virtual machines).  But it seems like the OpenCSW is flagging that it is unable to pull down fusioninventory_agent from the cpan repos.

See an example session below:
================================
bash-3.2# pkgutil -i CSWfusioninventory-agent
Solving needed dependencies ...
Package CSWfusioninventory-agent not in catalog. Exiting.
bash-3.2# pkgutil -a fusioninventory
common               package              catalog                        size

No exact matches found, doing fuzzy matching for first argument (fusioninventory) ...
bash-3.2#
========================================
And from this OpenCSW web site:
http://www.opencsw.org/qa/package/fusioninventory_agent/

See the uWatch section .. ==> Last Output:
The server couldn't fulfill the request during retrieval of : http://search.cpan.org/~fusinv/fusioninventory-agent Error code: 404

so, it seems it is probably a URL/URI typo that can easily be fixed .. 
