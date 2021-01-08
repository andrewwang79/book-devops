# bash脚本

## 命令使用
1. \`cmd`，$(cmd) // 反引号执行命令【不同于shell内的函数调用，相当于执行命令】，可以将结果保存到全局变量或者输出io返回。return返回值只能是整数，非0(错误)都会退出整个程序
1. "$(dirname "$path")" // 获取path的上级目录全路径
1. "$(basename "$path")" // 获取path的名称
1. echo PWD:\`pwd` // 显示当前路径
1. exit // 退出
1. $(date +%s) // 自1970年到现在的秒数
1. $(date +%Y%m%d-%H%M%S) // 年月日时分秒
1. ls $DIR | grep .jar | awk '{print "'$DIR'/"$0}' | tr "\n" ":" // 把目录里的所有jar文件用":"组成字符串
1. . data.properties，source data.properties // 加载属性文件的变量成为临时环境变量
1. .source common.sh // 加载通用函数
1. grep $old -rl $path | xargs -r sed -i "s#$old#$new#g" // 替换path下所有文件内容old->new
1. var=${1:-"DefaultValue"}
 // 设置var值，输入参数1不存在则是默认值。[参考](http://www.mojidong.com/linux/2012/09/08/shell-set-default-value/)

## 参数使用
1. 输入参数使用：$N。$1第一个参数
1. 变量定义和赋值，等号左右不能有空格：P1="ppp"
1. 变量使用：${P1}，$P1
1. declare -a array // 数组定义
1. declare -A map // 字典定义

## 常用语法
### 获取函数返回值
```
function fa() {
  name=$1
  echo hello${name}
}
name1=andrew
text=$(fa ${name1})
```

### 获取输入
```
read -e -p "Please input the correct option: " Number
if [[ ! "${Number}" =~ ^[1-5,q]$ ]]; then
echo "${CFAILURE}input error! Please only input 1~4 and q${CEND}"
else
case "${Number}" in
```

### 判断
* https://www.cnblogs.com/sunyubo/archive/2011/10/17/2282047.html

```
// 输入参数1是否存在
if [ -n "$1" ] ;then
    echo "exist"
else
    echo "not exist"
fi

// 变量是否存在
if [ ${var} ]; then
    echo "exist"
else
    echo "not exist"
fi

// bool值判断
var=true
if [ ${var} = true ]; then
    echo 'var is true'
fi

// 变量相等
if test ${var} = "123"; then
fi

//  变量比较
if [ "${var}"x != ""x ]
then
  echo "exist ${var}"
else
  echo "not exist"
fi

// 大小写忽略的正则式匹配
if echo "${DB_Ver}" | grep -Eqi '^8.0.|^5.7.|^10.2.'; then
fi

// 命令执行
if ! command; then
  echo "cmd failed";
  exit 1;
fi

// 命令执行结果判断
netstat -apn | grep 8080
if [ "$?" == 0 ]; then // 命令返回是空
fi

// 目录存在
if [ -d "${dir}" ]; then
fi
// 目录不存在
if [ ! -d "${dir}" ]; then
fi

// 文件存在
if [ -f "${file}" ]
then
fi
```

### 循环
```
for item in ${array[@]}; do
  echo "${item}"
done

for k in ${!map[*]}; do
    key=${k}
    val=${map[$k]}
done
```

### 获取函数的return：以下代码单独可以，放到复杂环境无效(原因未知)
```
function func1(){
  return 3
}

# 在$()的圆括号中可以执行linux命令,当然也包括执行函数
res1=$(func1)
# 变量res2将会接收函数的返回值，这里是3。在调用和获取间不能执行任何命令，比如echo
res2=`echo $?`
echo $res2
echo $res1
```

## 方案
### 等待服务启动
```
while [ -n "`ps -ef | grep mysql | grep -v grep | awk '{print $2}'`" ]; do
    sleep 1
done
```

### 属性文件读取
```
while read -r line; do
    if [ "$line" != "" ]; then
        IFS='=' read -r k v <<< $line
        echo "load key($k), val($v)"
        map[$k]=$v
    fi
done < $file
```

## 资料
### 语法
* [SHELL(bash)脚本编程二：语法](https://segmentfault.com/a/1190000008080537)
* [函数](https://www.runoob.com/linux/linux-shell-func.html)
* [数组](https://blog.csdn.net/ysdaniel/article/details/7909824)
* [整数型变量自增（加1）的实现方式](https://blog.csdn.net/yumushui/article/details/53469845)
* [$() ` `，${}，$[] $(())，[ ] (( )) [[ ]]作用与区别](https://blog.csdn.net/x1269778817/article/details/46535729)
* [shell脚本中的if 参数-a至-z](https://blog.csdn.net/shenhuxi_yu/article/details/53047012)
* [if多条件判断](https://www.cnblogs.com/jjzd/p/6397495.html)
* [Shell编程中Shift的用法](https://www.cnblogs.com/image-eye/archive/2011/08/20/2147153.html)

### 工具
* [sed](http://jalan.space/2017/01/22/2017-01-22-shell-sed-replace-text/)
* [bash/shell 解析命令行参数工具：getopts/getopt](https://my.oschina.net/leejun2005/blog/202376)

### 方案
* shell调用：1个参数有多个值时中间有空格，则调用参数必须加双引号。如p1="-a -b"，sh xxx.sh "${p1}"
* Ubuntu用bash替换dash：sudo dpkg-reconfigure dash，选择“No”, ls -l /bin/sh
* [创建交互式shell脚本对话框](https://www.linuxprobe.com/create-interactive-shell-script.html)
* [linux expect 自动交互脚本用法](https://yq.aliyun.com/articles/701512)
