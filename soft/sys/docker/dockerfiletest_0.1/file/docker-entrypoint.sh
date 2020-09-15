#!/bin/bash
pwd
echo "---data---"
ls /data

# 写hello到文件(第一个参数)
echo "hello" > /data/$1.txt

# 赋权限，执行并打印执行文件(第二个参数)的执行结果
chmod 777 $2
./$2
RETURN=$?
echo
echo "result:"$RETURN

echo "end"
