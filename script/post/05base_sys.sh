#!/bin/sh
#****************************************************************#
# ScriptName: 00base_sys.sh
# Author: $liujmsunits@hotmail.com
# Create Date: 2015-05-07 05:18
# Modify Author: $liujmsunits@hotmail.com
# Modify Date: 2015-05-07 05:18
# Function: 
#***************************************************************#
function modify_dns(){
echo "search	zj.chinamobile.com
nameserver	10.70.5.5
nameserver	10.70.39.5" >> /etc/resolv.conf
}

function modify_base_ntp(){
echo "server 10.70.213.132 version 3 prefer
server 10.70.213.133 version 3
disable monitor" >> /etc/ntp.conf
}

function modify_jifei_ntp(){
echo "server 10.254.48.23 version 3 prefer
disable monitor" >> /etc/ntp.conf
}


function modify_limits_conf(){
echo "* soft nofile 16384
* hard nofile 20480" >> /etc/security/limits.conf
}

modify_dns
modify_base_ntp
#modify_jifei_ntp
modify_limits_conf

