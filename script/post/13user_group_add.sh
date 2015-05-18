#!/bin/sh
#****************************************************************#
# ScriptName: 13user_group_add.sh
# Author: liujmsunits@hotmail.com
# Create Date: 2013-04-12 13:49
# Modify Author: liujmsunits@hotmail.com
# Modify Date: 2015-05-07 06:24
# Function: 
#***************************************************************#
function group_add(){
	#you can add the group that need to add to the grouplist.
	grouplist="
	users:100
	logs:1338
	ads:1685
	database:1239
	"
	for i in $grouplist;do
		gid=`echo $i|cut -d ':' -f2`
		group=`echo $i|cut -d ':' -f1`
		groupadd -g $gid $group;
	done
}


function user_add(){
	#you can add the user that need to add to the grouplist.
	#before the : is username,after the : is user group ,if no group then use then username.
	userlist="
	admin:admin
	logs:logs
	mysql:database
	db:database
	"
	for i in $userlist;do
		gid=`echo $i|cut -d ':' -f2`
		user=`echo $i|cut -d ':' -f1`
		useradd -g $gid $user;
		if [[ $? != 0 ]];then
			echo "$user add fail,may be the group $gid dosn't exist" >> $errorfile
		fi
	done
}

function key_init(){
	cp $PWD/conman/system/root.id_rsa /root/.ssh/id_rsa
	cp $PWD/conman/system/root.id_rsa.pub /root/.ssh/id_rsa.pub
	chown root:root /root/.bash*
	chmod 600 /root/.ssh/id*
}

user_add
