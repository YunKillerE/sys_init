前期准备：
	
	本来打算是让脚本sys_init.sh自动配置httpd服务的，但是考虑到跨平台性，就取消，需要手动配置httpd服务，根目录/home/sys_init/，就是当前脚本目录Alise一下就好了，端口9999.

使用方法：

	直接执行sys_init.sh脚本，按提示输入本机ip及目标主机的root密码,默认情况会自动获取本机ip以及默认密码root

文件目录解释：

	iphost	需要登录进行配置的主机ip
	script	脚本目录
	
