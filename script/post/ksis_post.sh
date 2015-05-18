#!/bin/sh
#****************************************************************#
# ScriptName: ksis_post.sh
# Author: liujmsunits@hotmail.com
# Create Date: 2012-05-29 13:15
# Modify Author: liujmsunits@hotmail.com
# Modify Date: 2015-05-07 06:32
# Function:  
#***************************************************************#
function send_mail() {
[ "$JIMMYSN" == "" ]&& JIMMYSN=`hostname`
[ "$DHCPIP" == "" ]&& DHCPIP=`ifconfig |grep "inet addr" |grep -v 127.0.0.1 |awk '{print $2}' |cut -d ':' -f2`
if ( /sbin/ifconfig|grep -iE -q 'inet ?addr:10.' ) ; then
    local smtpserver="127.0.0.1"
else
    local smtpserver="$DHCPIP"
fi
local mailfrom="KSIS_ERROR@KSIS.com"
local mailto="liujmsunits@hotmail.com"
local SUBJECT="ksis_post.sh run wrong! please check"
local message="HN: $JIMMYSN IP: $DHCPIP ksis_post.sh fail:  $1"
nc ${smtpserver} 25 <<-EOF >/dev/null 2>&1
mail from:<${mailfrom}>
rcpt to:<${mailto}>
data
From:<${mailfrom}>
To:<${mailto}>
subject:${SUBJECT}
===============================================================
${message}
===============================================================
.
quit
EOF
}

function error_log(){
echo $1 >>/root/post/errorfile.log
send_mail "$1" &
exit 1
}
function progress(){
:
}

for i in `ls /root/post/[0-9]*.sh`
do
	source $i 2>&1|tee -a /root/post/ksis_post.log
done

