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

# if you want to run restund as service copy the 'service/restund.service' to /etc/systemd/system/ and run below commands and you have to make sure in restund.conf file you set deamon no.

cd ..
cp service/restund.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable restund
sudo systemctl start restund
systemctl status restund


# Now the installation of this server is done. But before we start the server we shall need to configure restund.auth and restund.conf file in etc folder in restund and then copy them in system /etc/ folder. Lets first configure restund.auth file.

# Configuring restund.auth. For this we first need to generate a ha1 hash by added user realm and pass. the command is like below.

cd restund/
sudo util/genha1.sh $USER $REALM $PASS >> etc/restund.auth

# Here util is under restund folder.

# this whole part above can be done by running the build.sh file

# Now we have to configure etc/restund.auth . Giving a sample Conf file below 

#
# restund.conf
#

# core
daemon			no
debug			no
realm			**REALM**
syncinterval		600
udp_listen		**BIND_IP:BIND_PORT**
#udp_listen		1.2.3.4:3478
udp_sockbuf_size	524288
tcp_listen		**BIND_IP:BIND_PORT**
#tcp_listen		1.2.3.4:3478
#tls_listen		1.2.3.4:5349,/etc/cert.pem
#dtls_listen		1.2.3.4:5349,/etc/cert.pem
#dtls_sockbuf_size	524288
#dtls_hash_size		512

# modules (STUN messages are processed in module loading order)
module_path		/usr/local/lib/restund/modules
module			stat.so
module			binding.so
module			auth.so
module			turn.so
#module			mysql_ser.so
module			filedb.so
#module			restauth.so
module			syslog.so
module			status.so

# auth
auth_nonce_expiry	3600

# turn
turn_max_allocations	512
turn_max_lifetime	600
turn_relay_addr		**BIND_IP**
turn_relay_addr6	::1
turn_min_udp_alloc_port    **MIN_PORT**
turn_max_udp_alloc_port    **MAX_PORT**

# mysql
mysql_host		localhost
mysql_user		ser
mysql_pass		heslo
mysql_db		ser
mysql_ser		0

# filedb
filedb_path		/etc/restund.auth

# syslog
syslog_facility		24

# status
status_udp_addr		**BIND_IP**
status_udp_port		33000
status_http_addr	**BIND_IP**
status_http_port	9999



# after saving the configuration you have to copy the etc folder to system etc that means /etc/ folder

cd restund/
cp ./etc/* /etc/

# now all done.. :)
# please run below command to start the turn server

restund

# after running we need the check if the ports are bound properly.

netstat -nlp | grep restund

```


IETF RFCs:
==

* RFC 5389 - Session Traversal Utilities for NAT (STUN)
* RFC 5766 - Traversal Using Relays around NAT (TURN): Relay Extensions to
             Session Traversal Utilities for NAT (STUN)
* RFC 5780 - NAT Behavior Discovery Using Session Traversal Utilities for
             NAT (STUN)
* RFC 6156 - Traversal Using Relays around NAT (TURN) Extension for IPv6
