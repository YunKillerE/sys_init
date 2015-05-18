#!/bin/sh
#****************************************************************#
# ScriptName: done.sh
# Author: shoukun.taosk@alibaba-inc.com
# Create Date: 2012-05-30 16:21
# Modify Author: $liujmsunits@hotmail.com
# Modify Date: 2015-05-07 00:08
# Function: 
#***************************************************************#

for i in `ls post/*.sh`
do
	bash -n $i
	[ $? != 0 ]&& echo "$i.sh error"&&exit 1
done

if [ -e post.tgz ]
  then
	mv post.tgz post-`date +%Y%m%d%H%M%S`.tgz
  else
	:
fi
cd post
tar -zcvf ../post.tgz .
