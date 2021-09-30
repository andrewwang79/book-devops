# bash脚本

## 命令使用
### 常用
```
`cmd`，$(cmd) // 反引号执行命令【不同于shell内的函数调用，相当于执行命令】
  可以将结果保存到全局变量或者输出io返回。
  非0(错误)都会退出整个程序，不想退出可以捕获异常，比如：dir=$(cd .; pwd) || dir=
如果
dir=$(cd .; pwd) // 获取本层的绝对路径
parent_dir=$(cd ..; pwd) // 获取上层的绝对路径
parent_dir=$(dirname "$path") // 获取path的上级目录绝对路径，path必须是绝对路径
name=$(basename "$path") // 获取path的名称，path必须是绝对路径
echo PWD:\`pwd` // 显示当前路径
exit 0 // 退出，0是成功，>0是错误
$(date +%s) // 自1970年到现在的秒数
$(date +%Y%m%d-%H%M%S) // 年月日时分秒
ls $DIR | grep .jar | awk '{print $0}' | tr "\n" ":" // 遍历目录里的所有jar文件用":"组成字符串
. data.properties，source data.properties // 加载属性文件的变量成为临时环境变量
source common.sh // 加载通用函数文件，如果“加载文件”加载了x.sh，那相当于当前文件也加载了x.sh。不要用相对路径加载，因为相对路径是相对于第一个执行的bash文件的路径。
grep $old -rl $path | xargs -r sed -i "s#$old#$new#g" // 替换path下所有文件内容old->new
使用envsubst命令替换掉配置文件中的配置项: https://blog.csdn.net/zh515858237/article/details/79218176，源路径和目标路径必须不一样
_variable_names="\${V1} \${V2}" && envsubst "${_variable_names}" < ${tplFilePath} > ${targetFilePath}
var=${1:-"DefaultValue"} // 设置var值，输入参数1不存在则是默认值。[参考](http://www.mojidong.com/linux/2012/09/08/shell-set-default-value/)
```

### 命令连接符(&&, ||)的区别
1. cmd1 ; cmd2	cmd1 和 cmd2 都会 被执行
1. cmd1 && cmd2	如果 cmd1 执行 成功 则执行 cmd2
1. cmd1 || cmd2	如果 cmd1 执行 失败 则执行 cmd2

### 脚本执行错误后退出
* [设置Shell脚本执行错误自动退出](https://lintingbin2009.github.io/2017/07/06/%E8%AE%BE%E7%BD%AEShell%E8%84%9A%E6%9C%AC%E6%89%A7%E8%A1%8C%E9%94%99%E8%AF%AF%E8%87%AA%E5%8A%A8%E9%80%80%E5%87%BA/)

```
--文件级别--
#!/bin/bash
set -e // 任何错误会退出。只需要加到主程序文件【sh xyz.sh，sh后的都属于主程序文件】，不需要加到依赖文件。忽略错误是"set +e"

文件中错误会被忽略的写法：用命令连接符(&&, ||)拼接命令，前面命令(command1)错误后不会触发退出，因为错误被命令连接符捕获处理了。
重要逻辑不要用命令连接符，简单确定逻辑可用，比如cd && ls
command1 && command2
command1 || command2

--命令级别--
command || exit 1
```

### 脚本执行不输出信息
* 有echo返回值的函数，中间脚本执行如有echo，用本方法

```
./test2.sh > /dev/null 2 > &1 // test2.sh的标准输出和错误输出都重定向，不会有输出
符号“>”：把标准输出进行重定向输出
/dev/null：可以理解为linux下的回收站
2 > &1：把出错输出也重定向输出
```

## 参数使用
1. 输入参数使用：$N。$1第一个参数
1. 变量定义和赋值，等号左右不能有空格：P1="ppp"
1. 变量使用：${P1}，$P1。注意$10会成为${1}0
1. declare -a array // 数组定义。由整数索引的数组
1. declare -A map // 字典定义。由字符串索引的关联数组

## 常用语法
### 暂停
```
read -p "press any key to continue"
```

### 获取函数返回值
```
function fa() {
  name=$1
  echo "hello${name}"
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
  1) echo hi;;
  2) echo hi;;
  *) echo hi;;
esac
```

### 判断
* https://www.cnblogs.com/sunyubo/archive/2011/10/17/2282047.html

```
// 输入参数1是否存在
if [ -n "$1" ]; then
    echo "exist"
else
    echo "not exist"
fi

// 变量var存在
if [ -z ${var} ];then
	echo "not exist"
else
  echo "exist"
fi

// 整数判断
_file_count=`ls -l | grep "^-" | wc -l` # 文件数量
if [ ! ${_file_count} == 3 ]; then
  echo "error : file number is wrong"
  exit 1
fi

// bool值判断
var=true
if [ ${var} = true ]; then
    echo 'var is true'
fi

// 字符串变量比较
if test ${var} = "123"; then
fi

// 字符串变量startwith，要用&必须使用两个中括号
if [[ "${var}" != "" && "${var}" == B* ]]; then
  echo 'var start with B'
else
  echo "Not matched"
fi

//  字符串变量比较
if [ "${var}"x != ""x ]; then
  echo "exist ${var}"
else
  echo "not exist"
fi

// 大小写忽略的正则式匹配
if echo "${DB_Ver}" | grep -Eqi '^8.0.|^5.7.|^10.2.'; then
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

function commandxyz() {
    return 0
}
// 命令执行
if ! commandxyz; then
  echo "cmd返回非零"
  exit 1
else
  echo "cmd返回零"
  exit 0
fi

// 命令执行结果判断，处理错误
// 命令返回是0，表示执行成功
netstat -apn | grep 8080
// 方案1
if [ $? -ne 0 ]; then
    echo 'fail'
    exit 1
fi
// 方案2
if [ $? == 0 ]; then
  echo "success"
else
  echo "fail"
  exit 1
fi
// 方案3
netstat -apn | grep 8080 || ! echo 'fail' || exit 1
```

### 循坏遍历数组/字典
```
// array
declare -a abc_array
abc_array=(135 136 158)
abc_array=(s1 s2)
for item in ${abc_array[@]}; do
  echo "${item}"
done

// map
declare -A abc_map
abc_map[jim]=135
abc_map=([jim]=135 [tom]=136 [lucy]=158)
for k in ${!abc_map[@]}; do
    key=${k}
    val=${abc_map[$k]}
done
```

### 获取函数的return：以下代码单独可以，放到复杂环境无效(原因未知)
```
function func1() {
  return 3
}

# 在$()的圆括号中可以执行linux命令,当然也包括执行函数
res1=$(func1)
# 变量res2将会接收函数的返回值，这里是3。在调用和获取间不能执行任何命令，比如echo
res2=`echo $?`
echo $res2
echo $res1
```

### 字符串转成数组
```
string="hello shell split test"  
array=(`echo $string`)  
for var in ${array[@]}
do
   echo "${var}"
done
```

### json解析
* [jq 常用操作](https://mozillazg.com/2018/01/jq-use-examples-cookbook.html)
  * jq -h
  * jq -r '.[]' // 使用 -r 选项输出字符串原始值而不是 json 序列化后的值。相当于字符串去掉""
* [在线测试网址](https://jqplay.org/)

```
# 获取json属性值
jsontext='{"version" : "si", "ackage_time" : "eti"}'
ver=$(echo $jsontext | jq -cr ".version")
echo ver

# 遍历json数组
jd='[["a1", "b1"], ["a2", "b2"]]'
echo ${jd} | jq -cr '.[]' > $$tmp # 写到文件
while read i; do # 遍历数组，内部变量和外面是相通的
  echo i=${i}
  echo $(echo ${i} | jq -cr '.[0]') # 获取数组第n个值
  echo ${i} | jq -cr '.[]' | while read j; do # 遍历数组，管道后遍历的内部变量和外面是不通的
    echo j=${j}
  done
done < $$tmp
rm -f $$tmp
```

### 文件操作
```
text=$(cat ./p.txt)
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

### 不同颜色效果的输出文字
* [使用echo输出带颜色的字体](https://www.cnblogs.com/linusflow/p/7399761.html)
```
echo -e "\033[4;32;47m"hi\""\033[0m" // hi"
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
* [switch和case](https://blog.csdn.net/guodongxiaren/article/details/39758457)
* [Shell编程中Shift的用法](https://www.cnblogs.com/image-eye/archive/2011/08/20/2147153.html)
* [遍历目录下的文件](https://www.cnblogs.com/kaituorensheng/archive/2012/12/19/2825376.html)
* [Shell脚本递归遍历目录](https://www.jianshu.com/p/edbdff7a83c9)

### 工具
* [sed](http://jalan.space/2017/01/22/2017-01-22-shell-sed-replace-text/)
* [bash/shell 解析命令行参数工具：getopts/getopt](https://my.oschina.net/leejun2005/blog/202376)

### 方案
* shell调用：1个参数有多个值时中间有空格，则调用参数必须加双引号。如p1="-a -b"，sh xxx.sh "${p1}"
* Ubuntu用bash替换dash：检查(ls -l /bin/sh), 替换(sudo dpkg-reconfigure dash，选择“No”), [dash和bash区别](https://www.jianshu.com/p/762d4cccee7e)
* [创建交互式shell脚本对话框](https://www.linuxprobe.com/create-interactive-shell-script.html)
* [linux expect 自动交互脚本用法](https://yq.aliyun.com/articles/701512)
