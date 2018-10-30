Restund turn server for linux systems
==

[Source code](http://www.creytiv.com/restund.html)

This is an edited version of the restund turn server from above link. In this veriosn mainly we have mainly added udp turn allocation port range from configuration file. 


Supported platforms:
==

* Linux
* FreeBSD
* OpenBSD
* NetBSD
* Solaris
* Apple Mac OS X


Design goals:
==

* Modular STUN/TURN server
* STUN and TURN support
* IPv4 and IPv6 support
* UDP, TCP and TLS support
* RFC-compliancy
* Robust, fast, low footprint
* Portable C89 and C99 source code


Modular Plugin Architecture:
==

* STUN messages:    auth binding stat turn
* Database backend: mysql_ser
* Server status:    status
* Logging:          syslog

Installation Guide:
==

```
# Installing re

cd re/
make
sudo make install

cd ..

# Installing restund

cd restund/
make
sudo make install

# For some systems /usr/local/lib is not automatically loaded in library path. for these systems we need to add this to library path manually by entering belo commands

sudo echo "/usr/local/lib" > /etc/ld.so.conf.d/restund.conf
sudo ldconfig

# Now the installation of this server is done. But before we start the server we shall need to configure restund.auth and restund.conf file in etc folder in restund and then copy them in system /etc/ folder. Lets first configure restund.auth file.

# Configuring restund.auth. For this we first need to generate a ha1 hash by added user realm and pass. the command is like below.

cd restund/
sudo util/genha1.sh $USER $REALM $PASS >> etc/restund.auth

# Here util is under restund folder.


```


IETF RFCs:
==

* RFC 5389 - Session Traversal Utilities for NAT (STUN)
* RFC 5766 - Traversal Using Relays around NAT (TURN): Relay Extensions to
             Session Traversal Utilities for NAT (STUN)
* RFC 5780 - NAT Behavior Discovery Using Session Traversal Utilities for
             NAT (STUN)
* RFC 6156 - Traversal Using Relays around NAT (TURN) Extension for IPv6
