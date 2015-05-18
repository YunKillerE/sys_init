#!/bin/sh
#****************************************************************#
# ScriptName: modify_chkconfig.sh
# Author: liujmsunits@hotmail.com
# Create Date: 2015-04-29 16:08
# Modify Author: liujmsunits@hotmail.com
# Modify Date: 2015-05-07 06:03
# Function: 
#***************************************************************#
function modify_chkconfig()
{
	/sbin/chkconfig --level 35 $1 on
	/sbin/chkconfig --list |grep $1
}

#you add the sevice name that need to autostart to the grouplist
grouplist="
vsftpd
ntp
"

for i in $grouplist
do
	modify_chkconfig $i
done

echo "CHKCONFIG_FLAG"


