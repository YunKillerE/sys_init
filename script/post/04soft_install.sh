#!/bin/sh
#****************************************************************#
# ScriptName: 04soft_install.sh
# Author: $liujmsunits@hotmail.com
# Create Date: 2015-05-07 05:29
# Modify Author: $liujmsunits@hotmail.com
# Modify Date: 2015-05-07 05:29
# Function: 
#***************************************************************#
PWD=`pwd`
touch $PWD/errorfile.log
errorfile="$PWD/errorfile.log"

function rpm_install(){
rpm -ivh $1
}

for i in `ls $PWD/soft/*.rpm`
do
	rpm_install $i
done

cp -rf $PWD/soft/vsftpd.conf /etc/vsftpd.conf


