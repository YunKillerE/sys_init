#!/bin/bash
#****************************************************************#
# ScriptName: function.sh
# Author: $liujmsunits@hotmail.com
# Create Date: 2015-05-06 22:15
# Modify Author: liujmsunits@hotmail.com
# Modify Date: 2015-05-10 23:43
# Function: 
#***************************************************************#
auto_ssh_copy_id(){
#	pass="root"
	expect -c "set timeout 10;
    	spawn ssh-copy-id $1;
  		expect *assword:*;
		send -- $pass\r;
		interact;";
}

#auto_ssh_copy_id 192.168.218.199


auto_login_ssh(){
	expect -c "set timeout -1;
		spawn -noecho ssh -o StrictHostKeyChecking=no $2 ${@:3};
		expect *assword:*;
		send -- $1\r;
		interact;";
}
auto_login_ssh r00tadmin client "ifconfig eth0 && cat /root/.ssh/id_rsa"










