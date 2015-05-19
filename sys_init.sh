#!/bin/bash
clear                                                                                           
echo ""
echo -e "\033[7m"
echo "+---------------------------------------------------------------------+"    
echo "+                                                                     +"    
echo "+          System Initialization V0.1 Test Vension                    +"  
echo "+               Platform: red hat Linux  6.4                          +"    
echo "+               2015-05-06                                            +"    
echo "+---------------------------------------------------------------------+"
echo -e "\033[0m"
echo
PWD=`pwd`
usage()
{
echo "Usage: please use it like [ $0 172.16.3.1 ]"
exit 1
}
init()
{
  echo ""
  IP=`/sbin/ifconfig | grep "inet addr"| grep -v "127.0.0.1"| grep -v "255.255.255.255" |awk '{print $2}'| awk -F":" '{print $2}'`
  echo ""
  echo "输入当前主机IP是为了配置httpd服务，方便其他机器下载脚本，httpd服务运行在9999端口"
  echo ""
  echo "请输入当前主机IP（如：125.39.87.1）:"
  read -p "(Default: $IP):" temp
  if [ "$temp" != "" ]; then
    IP=$temp
	echo "IP=$IP"
	echo ""
  fi
#  PASSWD="r00tadmin"
  PASSWD="root"
  echo "请输入机器的root密码："
  read -p "(Default: $PASSWD):" temp
  if [ "$temp" != "" ]; then
    PASSWD=$temp
	echo "PASSWD=$PASSWD"
  fi
  echo ""
 }
 
init 
#yum install -y httpd
httpdinstall(){
rpm -ivh  soft/apr-util-ldap-1.3.9-3.el6_0.1.x86_64.rpm
rpm -ivh  soft/httpd-tools-2.2.15-15.el6.x86_64.rpm
rpm -ivh  soft/httpd-2.2.15-15.el6.x86_64.rpm
}

httpdinstall

if grep sys_init /etc/httpd/conf/httpd.conf;then
	:
else

cat >> /etc/httpd/conf/httpd.conf <<EOF
Alias /sys_init/ "/home/sys_init/"
<Directory "/home/sys_init/">
Options Indexes FollowSymLinks
AllowOverride None
Order allow,deny
Allow from all
</Directory>
EOF

fi

sed -i "/^Listen/d" /etc/httpd/conf/httpd.conf
sed -i "/#Listen/a  \Listen 9999" /etc/httpd/conf/httpd.conf

service httpd restart
echo "httpd setup done!"

cp -rf $PWD/script/run.sh.base $PWD/script/run.sh
sed -i "s/@KS@/$IP/g" $PWD/script/run.sh

echo "run.sh setup ok!"

#自动登录下载run.sh脚本

if [ -e $PWD/iphost ];then
	:
else
	echo "请将需要初始化的服务器ip或主机名（前提能正常解析）加入到iphost文件中"
fi

auto_ssh_copy_id(){
	expect -c "set timeout 60;
    	spawn ssh-copy-id $1;
  		expect *assword:*;
		send -- $1\r;
		interact;";
}
#auto_ssh_copy_id 192.168.218.199

auto_login_ssh(){
	expect -c "set timeout 60;
		spawn -noecho ssh -o StrictHostKeyChecking=no $2 ${@:3};
		expect *assword:*;
		send -- $1\r;
		interact;";
}
#auto_login_ssh root 192.168.218.199 "ls /root && ls /var"


for i in `cat $PWD/iphost`
do
	echo $PASSWD
	echo $i
	auto_login_ssh $PASSWD $i "rm -rf /root/run.sh && mkdir /root/post && touch /root/post/install.log && /usr/bin/wget -T3 -t2 http://$IP:9999/sys_init/script/run.sh -O /root/run.sh && /usr/bin/nohup sh /root/run.sh 2>&1 >/root/post/install.log &"
done

