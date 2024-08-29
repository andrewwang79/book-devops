# 常用

## 常用参数定义
* -R : 目录递归
* -C : 设置工作目录

## 文本匹配
* cat debug.txt | grep abc
* cat debug.txt | grep "\[FE\]" // []是正则表达式，需加\。字符串需加双引号
* find . | xargs grep -ri "keyword" // 当前目录下的所有文件中是否含有某个字符串(keyword)
* find . | xargs grep -ri "keyword" -l // 当前目录下的所有文件中是否含有某个字符串(keyword)，只打印出文件名

## 文件属性
* [linux修改文件所属用户和组](http://www.cnblogs.com/jdonson/archive/2011/04/28/2031878.html)
* chmod -R 766 Document // 修改目录Document的权限。[命令详细 ](https://www.linuxdaxue.com/linux-command-intro-chmod.html)
* chmod -R ug+x Document // 目录Document的所有文件都加上执行权限(user + owner)
* chown -R user1 Document // -R 所有者 路径。修改目录Document的所有者成user1
* chgrp -R user1 Document // -R 所在组 路径。修改目录Document的所在组成user1

## 文件和目录
* mkdir -p /d1/d2 // 自动创建多层
* mv/cp src dest // 【dest目录存在则dest目录下是src目录(dest/src)，dest目录不存在则dest目录下是src目录里的具体内容(dest/*)】。
* cp -p /src dest // 属性不变的复制
* /bin/cp -R dir1 dir2 // 用/bin/cp不提示覆盖overwrite，cp默认有-i
* /bin/cp -R /dir1/. /dir2/ // 拷贝所有文件，含隐藏文件
* mv dir1/{.,}* /dir2/ || echo "no file" // 移动所有文件，含隐藏文件。异常会报错阻止主流程执行，当前用||处理掉
* mv/cp dir1/* ./ 比如cp -rf /etc/abc/* /opt/abc/，会把/etc/abc/下的内容拷贝到/opt/abc/，不会到/opt/abc/abc/  // dir1目录所有内容(不含dir1层级)移动/拷贝到当前目录。如dir1里有个dir2目录，则当前目录下有个dir2目录，没有dir1目录
* mv/cp dir1 ./ // dir1目录移动/拷贝到当前目录。即当前目录下有个dir1目录
* cp -rf path1 path2 destPath // 多个目录复制到目标路径，会复制链接文件。-P也会。
* mv path1 path2 -t destPath // 多个目录移动到目标路径
* find . -name *.txt -print0 | xargs -I file mv file ./ // 查找txt文件并移动到当前目录，只能移到当前目录。文件路径有空格会无效
* ln -s src_dir dest_dir // [建立软连接](https://www.cnblogs.com/peida/archive/2012/12/11/2812294.html)，从dest_dir[快捷目录]链接到src_dir[真实目录]
* unlink dest_dir // 取消软连接
* ls -a dir1 // 查看隐藏文件
* ls -l --time-style=full // 查看文件的年月日
* ls -lt // 时间最近的在前面
* ls -ltr // 时间从前到后
* [提取文件名和目录名](https://www.cnblogs.com/nzbbody/p/4391802.html)
* 统计文件夹下文件的个数: ls -lR | grep "^-" | wc -l
* 统计文件夹下文件夹的个数: ls -lR | grep "^d" | wc -l
* 分割文件批量改后缀：ls | grep .part. | xargs -n1 -i{} mv {} {}.tar.gz // XX.part.11变成XX.part.11.tar.gz

### 目录栈操作
* https://www.jianshu.com/p/53cccae3c443

```
pushd ${path} // 相对路径绝对路径都可以
script // 在目录${path}下执行
popd
```

## 文件操作
* stat file // 看文件属性
* [find示例](http://blog.csdn.net/windowschengxisheji/article/details/51019280)
  * find结果路径是绝对还是相对来自于查询的路径是绝对还是相对，比如find /opt/ -name xxx，结果是绝对路径
  * find / -name xyz // 指定文件全路径查找(xyz)
  * find / -name *xyz* // 指定文件全路径模糊查找(xyz)
  * find . -type f -size +100M // 查找大文件(100M)
  * find -delete //删除当前find的所有文件目录
  * find ${PATH} -type f -mtime +15 -exec rm {} \; // 删除目录下非最近15天的文件(不含目录)，-mmin是分钟
  * find ${PATH} -type f -mtime +15 -exec mv {} destPath \; // 删除目录下非最近15天的文件(不含目录)，-mmin是分钟
  * find ${PATH} -name "*.log"  | xargs rm -f// 删除目录下匹配的文件
* echo > filePath // 清空文件内容
* cat srcfile >> destfile // 将文件内容追加到另一个文件末尾
* rm -rf方式删除文件后，通过df -h会发现磁盘空间并没有释放
  * 原因是在Linux或者Unix系统中，通过rm -rf或者文件管理器删除文件，将会从文件系统的目录结构上解除链接（unlink）。如果文件是被打开的（有一个进程正在使用），那么进程将仍然可以读取该文件，磁盘空间也一直被占用。正确姿势是cat /dev/null > file，当然你也可以通过rm -rf删除后重启宿主进程
* rm -rf !(1.cf|2.conf) // 保留1和2，其他都删除

## 内存
* sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches' // 清除不用的缓存
* top // 查看所有进程，输入shift + m可根据内存使用量进行排序。输入e切换进程信息，切换单位是k,m,g,t,p
* top -c // 查看所有进程，显示进程命令的全路径与参数
* top -p 1111 // 查看特定进程(1111)
* top -H -p 111 // 查看特定进程的线程数量和信息(1111)
* ps -aux | sort -k4nr | head -5 // 使用内存最多的5个进程
* [单个进程的内存查看](https://www.cnblogs.com/jiayy/p/3458076.html) : cat /proc/[pid]/文件名。文件有maps/smaps/status。如“cat /proc/5346/status”
* [自动清理内存配置](https://blog.csdn.net/feiteyizu123/article/details/84910505)
```
sudo crontab -e
*/60 * * * * sh -c 'sync && echo 3 > /proc/sys/vm/drop_caches'
```

## 进程
* nohup 命令 >/dev/null & // 后台运行命令
* kill名称(mongo)对应的进程
  * pgrep -f mongo | xargs kill -9
  * ps -ef | grep mongo | awk '{print $2}' | xargs kill -9
* kill端口(27017)对应的进程 : lsof -t -i :27017 | xargs kill -9

## 进程查询
* ps -ef | grep 进程号 // 查看进程对应的执行命令
* ls -l /proc/PID/exe // 查看进程对应的程序
* ps -ef | grep java // 查看匹配名称的进程(java)
* ps -ef | grep nginx | wc -l // 查看运行的进程总数
* ps -fu csvn // 查看特定进程(csvn)
* lsof -i :9000 // 查看端口执行的进程(9000)
* 查看容器内的进程所属容器
```
cat /proc/进程号/cgroup
docker ps|grep 上个命令的容器id
```

## 传输
* wget {url} // 公网下载
* SCP: [SSH传输传输文件](http://blog.csdn.net/liuhongxiangm/article/details/17142611)。**没有参数"f"，输入会阻塞命令**
  * scp -P 22 -r localFilePath account@remoteIP:remoteFilePath // 上传，-P是SSH服务端的端口
  * scp -P 22 -r account@localIP:remoteFilePath localFilePath // 下载，-P是SSH服务端的端口
* sync -av --exclude excludePath /data/src/ /data/dest // 本地同步，排除文件夹(/data/src/excludePath)
* [远程同步](https://einverne.github.io/post/2017/07/rsync-introduction.html)
  * 语法：rsync 源端目录 目标端目录，如rsync -avzl abc/ backup/abc，目标端目录不要加/否则会在下层再创建个目录abc。l是保留符号链接
  * rsync -avzl -e "ssh -p 11111" /src_path account@host:/dest_path // 指定ssh的端口
  * rsync -avzl --delete /src_path account@host:/dest_path // 目标端"多则删之"，确保两个目录一致
  * rsync -avzl --remove-source-files backup.tar /tmp/backups/ // 同步后自动删除源文件，使用场景是源文件每次都是个新文件

## ssh
* ssh -p port user@host  如：ssh -p 2222 pika@192.168.0.111
* [sshpass](https://www.cnblogs.com/mianbaoshu/p/9648241.html)
  * 命令带密码登录: sshpass -p "password" ssh -p 2222 pika@192.168.0.111
  * 密码文件生成: echo 'password' > mypasswd.txt
  * 命令带密码文件登录: sshpass -f mypasswd.txt ssh -p 2222 pika@192.168.0.111
  * 命令带密码文件SCP: sshpass -f mypasswd.txt scp -r -p 2222 pika@192.168.0.111:/opt/foo/ .

### 连接失败的调试
* https://www.imooc.com/article/21437
```
目录权限是600
ssh客户端查看详细信息：ssh -vvv
服务端启动ssh服务，看log: /usr/sbin/sshd -d -p 2222
```

### 远程免密码登录设置
* [远程免密码登录设置](http://www.2cto.com/os/201304/205141.html), https://blog.csdn.net/alifrank/article/details/48241699
* 说明
  1. 秘钥是服务器级别的。登录账号同秘钥，放在远程服务器的对应账号的authorized_keys里。如秘钥放在用户A的authorized_keys里，那只能用户A登录远程服务器。
  1. 如果authorized_keys设置了但还是无效，注意目录.ssh和文件authorized_keys的权限，确保登录账号有权限
* 步骤：在本地电脑通过ssh免密登录远程服务器
  1. Windows本地生成公共密钥，秘钥在id_rsa.pub：ssh-keygen -t rsa
  1. 公共密钥授权方案1
    本地：ssh-copy-id root@192.168.1.138
  1. 公共密钥授权方案2
    1. 本地：cat ~/.ssh/id_rsa.pub
    1. 远程：nano ~/.ssh/authorized_keys，将本地文本拷贝进去

## 自动输入密码设置
* [资料](http://blog.itpub.net/27042095/viewspace-745587/)
1. 安装expect
1. 脚本
```
  expect -c "
  spawn scp ${src_user}@${src_host}:${src_path}
  expect \"password:\"
  send \"${pwd}\r\"
  expect eof
```

## 安全
* [HTTPS证书转换成PEM格式](https://help.aliyun.com/document_detail/40526.html)
* openssl x509 -in mycert.crt -out mycert.pem -outform PEM // ssl的crt生成pem, der/crt是X.509的(ASCII), pem是X.509的(Base64)

## 压缩解压
* [资料](https://www.cnblogs.com/joshua317/p/6170839.html)
* -C PATH// 设置程序当前工作目录
* tar -rvf // 通过r追加文件，只能用于tar
* tar -tf a.tar.gz // 在不解压的情况下查看压缩包的内容
* 说明：同一个源用zip压缩多次，因为压缩包文件里包含源和压缩信息(如压缩日期)，所以文件内容是不一致的(文件签名不一致)。修改压缩包文件的属性(如创建时间、修改时间)不改变文件签名。rar多次压缩的签名一致。

| 方式 | 操作 | 示例 |
| -- | -- | -- |
| tar(打包) | 打包 | tar -cvf example.tar files/dir |
|  | 解包 | tar -xvf example.tar  -C /path |
| tar.gz/tgz | 压缩 |  |
|  | 解压 |  |
| zip | 压缩目录 | zip -r example.zip abc |
|  | 解压，可以用于windows的文件和jar包 | unzip example.zip/jar |
| gzip | 压缩tar文件到tar.gz，自动成为a.tar.gz，目录结构不变 | gzip a.tar |
|  | 解压tar.gz文件到tar，自动成为a.tar | gzip -d a.tar.gz |

### tar.gz
#### 压缩
1. tar -zcvf e.tar.gz path // path可以是相对路径或绝对路径，压缩包里根目录是path。
1. tar -zcvf e.tar.gz -C dir path // 被压缩目录是“dir/path”，压缩包里根目录是path。
  1. tar -zcvf abc.tar.gz -C /opt/ abc // 被压缩目录是/opt/abc/，压缩包里根目录是abc
1. tar -zcvf abc.tar.gz --exclude='a/b' --exclude='a/c' a // a目录下的b和c排除不压缩
#### 解压
1. tar -zxvf example.tar.gz // 压缩包的文件放到当前目录下
1. tar -zxvf example.tar.gz -C dir // 压缩包的文件放到目录dir下
1. tar -zxvf a.tar.gz -C /opt/b/ --strip-components 1 // 把a的内容放到/opt/b/下面(不含a目录)
  1. --strip-components 1：取压缩包第几层文件夹文件，1就相当于解压时去掉压缩包的根目录

### rar
1. rar a all *.jpg // 将所有jpg文件压缩成all.rar
1. unrar e all.rar

## windows和linux回车不一样的处理(LF/CRLF)
* dos2unix/unix2dos：find . -type f -exec dos2unix {} \;

## 用户
* [用户和组](https://blog.csdn.net/MTbaby/article/details/52611423)
* [扩展用户管理](https://blog.csdn.net/PianoOrRock/article/details/79199317)
* sudo su // 用户切换到root。[Ubuntu中root用户和user用户的相互切换](https://www.cnblogs.com/weiweiqiao99/archive/2010/11/10/1873761.html)
* 用户启用sudo：需将账号加入到/etc/sudoers，user1 ALL=(ALL)NOPASSWD:ALL
* usermod -aG groupA user1 // 用户user1添加到组groupA
* groups user1 // 用户user1所属的组列表
* [linux下开启SSH，并且允许root用户远程登录,允许无密码登录](https://www.cnblogs.com/toughlife/p/5633510.html) : PermitEmptyPasswords yes

## 硬盘
* df // 硬盘容量
* du -sh path // 某一指定路径容量
* du . --max-depth=1 -h // 显示当前目录的空间容量
* du . --max-depth=1 -h | sort -nr // 顺序排序显示当前目录的空间容量
* df -ih // 索引文件情况
* ncdu /data // 目录空间扫描分析
* lsof | grep deleted // 显示已删除文件
* fdisk -l // 查看系统磁盘设备信息
* mount /dev/sdb1 /dir1 // 将U盘挂载到dir1
* echo '/dev/vdb /data ext4 defaults 0 0' >> /etc/fstab // 永久挂载vdb(格式是ext4)到路径/data/
* resize2fs /dev/vda // 扩容
* [解决类似umount target is busy挂载盘卸载不掉问题](https://www.cnblogs.com/ding2016/p/9605526.html)
* [检查和重新挂载](https://www.cnblogs.com/ding2016/p/9605526.html)
  * fsck -y /dev/sda2
  * umount /dev/sda2
  * rescue模式下可检查系统盘

## NFS
* [centos安装](https://qizhanming.com/blog/2018/08/08/how-to-install-nfs-on-centos-7)
* [ubuntu安装](
https://blog.csdn.net/CSDN_duomaomao/article/details/77822883)

### 通用操作
* showmount -e 127.0.0.1 // 显示此IP地址(不填是本机)通过NFS分享出来的目录

### 服务端相关操作
```
安装nfs
mkdir -p /backup/ && chmod -R 777 /backup/ // 全部权限
nano /etc/exports // 设置分享权限：/backup/是服务端目录，172.16.1.21是客户端
  /backup/ 172.16.1.21(rw,sync)
exportfs -arv // 重新加载/etc/exports文件
systemctl restart nfs // 重启NFS
```

```
服务机：

开放
  nano /etc/exports
  /backup/ 172.16.2.137(rw,sync) // 对客户机172.16.2.137开放服务机的目录/backup/
客户机：
mount -t nfs 172.16.2.137:/backup/
```

### 客户端相关操作
```
mkdir -p /biz/
nano /etc/fstab // 设置开机自动挂载目录[可选]，172.16.1.12是服务端
172.16.1.12:/backup/ /biz/ nfs rw

mount -t nfs 172.16.1.12:/backup/ /biz/ // 手工挂载目录
umount /biz/
```

## 监控
* watch -n 1 -d 'ps -ef | grep java' // 每秒钟执行一次命令，定时执行

## diff
* diff -r dir1 dir2 // 目录比对
* diff -Naur dir1 dir2 // [linux 比较两个文件夹不同 (diff命令, md5列表)](https://www.cnblogs.com/xudong-bupt/p/6493903.html)
* [vimdiff](https://www.jianshu.com/p/0541a67c6d3f)
* diff < (xxd A) <(xxd B) // [二进制文件比较](https://www.xiaoyuanjiu.com/108399.html)

## 补丁
* diff的输出文件被称为补丁（patch）。patch的作用则是将补丁应用到相应文件（夹）上
* [补丁(patch)的制作与应用](http://linux-wiki.cn/wiki/zh-hans/%E8%A1%A5%E4%B8%81(patch)%E7%9A%84%E5%88%B6%E4%BD%9C%E4%B8%8E%E5%BA%94%E7%94%A8)

## xargs
* https://www.linuxcool.com/xargs
* [管道命令和xargs的区别](https://www.cnblogs.com/sddai/p/8597135.html)

| 项 | 说明 | 输入 | 操作 |
| -- | -- | -- | -- |
| 管道 | 作为标准输入 | echo "--help" \| cat | 输入"cat"，手工输入--help |
| xargs | 作为命令参数 | echo "--help" \| xargs cat | 输入"cat --help" |

## 字符串分割截取命令
* [cut, printf, awk, sed](https://www.cnblogs.com/farwish/p/4806018.html)
* [sed命令中含有转义字符的解决方法](https://www.cnblogs.com/zwldyt/p/12996846.html)
* cut -d ' ' -f 1 // 分隔符是' '，取第一列
* awk '{print $1}' // 无条件的取第一列

## sha签名
```
sha512sum file | awk '{print $1}' > sign.sha512 // Linux的sha512单文件签名保存
find . -type f -not \( -name '.*' \) -print0 | xargs -0 sha512sum > sign.sha512 // 指定目录的所有文件签名保存
find . -type f -not \( -name '.*' \) -print0 | xargs -0 sha512sum | sort > sign.sha512 // 指定目录的所有文件签名排序保存
certutil -hashfile AbcV1.0.1.2.tar.gz SHA512 // Windows的sha512单文件签名保存
```

* 同样的内容和操作，两次操作的签名却不一致原因
  1. tar压缩，会加上压缩时间
  1. jar包生成，maven会加入当前时间到文件META-INF/maven/[package]/pom.properties

## 大文件分割合并
```
split -b 10m 大文件名 大文件名.part.
cat 大文件名.part.* > 大文件名

示例：
tar -zcvf abc.tar.gz dir
split -b 1024m abc.tar.gz abc.part.
cat abc.part.* > abc.tar.gz
tar -zxvf abc.tar.gz
```
* https://blog.csdn.net/lkforce/article/details/71547313
* https://blog.csdn.net/ybdesire/article/details/89597457
* https://blog.csdn.net/chenriwei2/article/details/50646601

## 僵尸进程和孤儿进程
* 资料
  * https://www.cnblogs.com/Anker/p/3271773.html
  * https://mozillazg.com/2017/07/python-how-to-generate-kill-clean-zombie-process.html
* ps -e -o ppid,stat,cmd | grep defunct // 查询僵尸进程
* ps -e -o ppid,stat,cmd | grep defunct | cut -d" " -f2 | xargs kill -9 // kill僵尸进程

## 系统日志(systemd-journal)
* [Centos 7/8 日志管理](https://www.cnblogs.com/vincenshen/p/12441492.html)
* [清除journal日志](https://blog.csdn.net/ithomer/article/details/89530790) : journalctl --vacuum-size=500M
* 查 : journalctl --disk-usage
* [自动清除](http://manpages.ubuntu.com/manpages/bionic/zh_CN/man5/journald.conf.5.html)
```
nano /etc/systemd/journald.conf
SystemMaxUse=200m
ForwardToSyslog=no
重启服务 : systemctl restart systemd-journald.service
```

## Ubuntu改坏sudoers后无法使用sudo的解决办法
https://www.qedev.com/linux/222196.html

## 压测工具
stress进行内存、CPU的压测
```
stress --vm 1 --vm-bytes 1000M  # 占用 1000MB 内存
stress -c 1                     # 占用 1core CPU
```

## 其他
* [linux查看已删除空间却没有释放的进程](https://blog.51cto.com/chentongsan/2459740):导致空间不足。lsof -n | grep deleted, kill -9 进程号(第二列)

## 终端复用工具
* [tmux vs screen](https://qianxu.run/2021/03/28/tmux-vs-screen/)
* tmux: 一屏多窗口
* screen可以让用户在同一个终端窗口中同时运行多个会话，并且可以在不同的会话之间快速切换。

```
screen -S abc // 启动screen会话，名称是abc
screen -d -r abc // 重新连接会话
screen -X quit // 在session里删除session
screen -X -S 3517453.abc quit // 在session外删除session
```

## 守护进程或服务
* Linux的Systemd
* Windows的NSSM，SrvStart