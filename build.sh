#!/bin/bash

#echo "Downloading RE"
#echo "--------------"
#wget http://www.creytiv.com/pub/re-0.5.9.tar.gz
#tar xf re-0.5.9.tar.gz
echo "Installing RE"
cd re/
make
sudo make install

cd ..

echo "***"
echo " * "
echo "***"

#echo "Downloading reStund Turn Server"
#echo "-------------------------------"
#wget http://www.creytiv.com/pub/restund-0.4.12.tar.gz
#tar xf restund-0.4.12.tar.gz
echo "Installing reStund Turn Server"
echo "------------------------------"
cd restund/
make
sudo make install

sudo echo "/usr/local/lib" > /etc/ld.so.conf.d/restund.conf
sudo ldconfig 

echo "****************** Installation Done *********************"

echo "Configuring reStund user/pass and restund.auth"
echo "Please enter Turn Username: "
read USER
echo "Please enter Turn Password: "
read PASS
echo "Please enter Turn Realm: "
read REALM

sudo util/genha1.sh $USER $REALM $PASS >> etc/restund.auth