#!/bin/bash

if [ ! -x /usr/bin/wget ] ; then
 echo "for some silly reason, wget is not executable.  Please fix this (as root do chmod +x /usr/bin/wget) and try again"
 exit
fi


//Install OpenSSL from source
yum install openssl-devel
cd /usr/src
wget http://www.openssl.org/source/openssl-1.0.1i.tar.gz
tar -zxf openssl-1.0.1g.tar.gz
cd openssl-1.0.1g
./config --prefix=/usr --openssldir=/usr/local/openssl shared
make
make test
make install
rm -rf openssl-1.0.1i.tar.gz
rm -rf openssl-1.0.1i

//Install other stuff
yum install openssl-devel
yum install git
yum install boost-devel db4 db4-devel
yum install gcc
yum install lboost
yum install g++
yum install gcc-c++
rpm -Uvh http://pkgs.repoforge.org/miniupnpc/miniupnpc-1.5-1.el6.rf.x86_64.rpm
rpm -Uvh http://pkgs.repoforge.org/miniupnpc/miniupnpc-devel-1.5-1.el6.rf.x86_64.rpm
yum update

//New user, download and compile
useradd reddcoin
cd /home/reddcoin
git clone https://github.com/reddcoin-project/reddcoin
cd /home/reddcoin/reddcoin/src
make -f makefile.unix BOOST_LIB_SUFFIX=-mt

//Download configuration file
mkdir /root/.reddcoin
cd /root/.reddcoin
wget http://pastebin.com/raw.php?i=qzZRNCHm -O reddcoin.conf
