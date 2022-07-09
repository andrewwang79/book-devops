# 常用

## 常用参数定义
* -R : 目录递归
* -C : 设置工作目录

## 环境变量
* 环境变量永久新增方法：文件追加行，如export path=$path:/path1:/pahtN
  * 于/etc/profile文件：对所有用户生效(永久的)
  * 用户目录下的.bash_profile文件，对单一用户生效(永久的)
* 环境变量在当前session的新增方法：export HELLO="Hello!"
* readonly TEST // 将环境变量TEST设为只读
* source /etc/profile // 人工重新加载和生效文件
* echo $HOME // 显示环境变量HOME
* env // 显示所有的环境变量

## 软件安装卸载
| 安装方式 | CentOS | Ubuntu |
| -- | -- | -- |
| 离线 | rpm安装: rpm -ivh xxx.rpm | dpkg安装卸载deb文件: dpkg --install  xxx.deb <br> [ubuntu的deb安装包](http://archive.ubuntu.com/ubuntu/pool/) |
| 在线 | yum | apt-get |

* ls -tl /var/lib/dpkg/info/*.list | head -n 10 // 查看最近安装的10个deb
* alien package_name.rpm // RPM转成DEB
* [Ubuntu16.04更换阿里云apt-get软件源](https://blog.csdn.net/yjk13703623757/article/details/79860133)

### CentOS
* 命令：telnet软件的安装
```
rpm -qa | grep telnet // 是否已安装telnet
yum -y install telnet-server
yum -y install telnet
```
* [CentOS软件包安装](https://blog.csdn.net/yinjiabin/article/details/7654852)
* [执行yum命令报except KeyboardInterrupt](https://blog.csdn.net/huangjin0507/article/details/82891412)：nano /usr/bin/yum，改成python2
* 数据源配置：[CentOS7配置网易163的yum源](http://www.cnblogs.com/carbon3/p/5635403.html)
```
cd /etc/yum.repos.d/
mv CentOS-Base.repo CentOS-Base.repo.backup
wget http://mirrors.163.com/.help/CentOS7-Base-163.repo
yum clean all
yum makecache
```

* [RPM软件包的安装及卸载](http://os.51cto.com/art/201001/177866.htm)
* [yum命令详解](http://www.cnblogs.com/chuncn/archive/2010/10/17/1853915.html)
* [选择需安装的包](https://codeantenna.com/a/9Rh9hQpwR9)
```
rpm -qa | grep "g++" && yum whatprovides "*/g++"
根据提供的包，选择适合系统的进行安装：
yum install 包名
```

### Ubuntu
* 命令
```
apt-get install xxxxx // 安装
apt-get remove xxxxx // 卸载
apt-get autoremove // 卸载
apt-cache search gcc // 搜索包gcc
apt list –installed // 显示已安装软件包
dpkg-query -l // 显示已安装软件包，结果同apt list
apt-get install aptitude // 软件包安装情况的软件
```

* [Ubuntu离线安装软件包](https://blog.csdn.net/nupt123456789/article/details/11649603)
* [apt-get安装出现dpkg status database is lock解决](http://www.2cto.com/os/201305/208284.html)，安装失败会导致其他软件不能使用，比如MySQL
```
    rm /var/lib/dpkg/lock
    dpkg --configure -a    
```

* [大量dpkg依赖错误](https://segmentfault.com/q/1010000000117928)

## 离线安装
* [官方安装包实例-docker](https://docs.docker.com/install/linux/docker-ce/binaries/#install-static-binaries)
* [第三方yum缓存工具](https://blog.csdn.net/Post_Yuan/article/details/79449175)
* [自己做yum缓存包](https://blog.csdn.net/bbg221/article/details/78360618)

## 系统信息
* cat /etc/issue       lsb_release -a // Ubuntu系统版本
* last reboot // 重启记录
* [Linux上如何查看物理CPU个数，核数，线程数](https://www.cnblogs.com/ivictor/p/6208573.html)
* cat /proc/cpuinfo |grep MHz|uniq // 查看CPU内核频率
* sudo dmidecode -s processor-version // 查看CPU型号

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
* /bin/cp -R dir1 dir2 // 用/bin/cp不提示覆盖overwrite，cp默认有-i
* /bin/cp -R /dir1/. /dir2/ // 拷贝所有文件，含隐藏文件
* mv dir1/{.,}* /dir2/ || echo "no file" // 移动所有文件，含隐藏文件。异常会报错阻止主流程执行，当前用||处理掉
* mv/cp dir1/* ./ 比如cp -rf /etc/abc/* /opt/abc/，会把/etc/abc/下的内容拷贝到/opt/abc/，不会到/opt/abc/abc/  // dir1目录所有内容(不含dir1层级)移动/拷贝到当前目录。如dir1里有个dir2目录，则当前目录下有个dir2目录，没有dir1目录
* mv/cp dir1 ./ // dir1目录移动/拷贝到当前目录。即当前目录下有个dir1目录
* cp -rf path1 path2 destPath // 多个目录复制到目标路径
* mv path1 path2 -t destPath // 多个目录移动到目标路径
* find . -name *.txt | xargs -I file mv file ./ // 查找txt文件并移动到当前目录
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

## 文件
* [find示例](http://blog.csdn.net/windowschengxisheji/article/details/51019280)
  * find结果路径是绝对还是相对来自于查询的路径是绝对还是相对，比如find /opt/ -name xxx，结果是绝对路径
  * find / -name xyz // 指定文件全路径查找(xyz)
  * find / -name *xyz* // 指定文件全路径模糊查找(xyz)
  * find . -type f -size +100M // 查找大文件(100M)
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
* top // 查看内存使用情况，输入shift + m可根据内存使用量进行排序。输入e切换进程信息，切换单位是k,m,g,t,p
* top -p 1111 // 查看特定进程号的内存(1111)
* top -c // 显示进程命令的全路径与参数
* ps -aux | sort -k4nr | head -5 // 使用内存最多的5个进程
* [单个进程的内存查看](https://www.cnblogs.com/jiayy/p/3458076.html) : cat /proc/[pid]/文件名。文件有maps/smaps/status。如“cat /proc/5346/status”
* [自动清理内存配置](https://blog.csdn.net/feiteyizu123/article/details/84910505)
```
sudo crontab -e
*/60 * * * * sh -c 'sync && echo 3 > /proc/sys/vm/drop_caches'
```

## 进程
* nohup 命令 >/dev/null & // 后台运行命令
* ps -ef | grep mongo | awk '{print $2}' | xargs kill -9 // kill名称对应的进程(mongo)
* // kill端口对应的进程(27017)，推荐第一种，第二种在Ubuntu下会把“PID”取出来导致kill失败
  * kill -9 $(sudo lsof -t -i:27017)
  * lsof -i :27017 | awk '{print $2}' | xargs kill -9

## 进程查询
* ps -ef | grep 进程号 // 查看进程对应的执行命令
* ls -l /proc/PID/exe // 查看进程对应的程序
* ps -ef | grep java // 查看匹配名称的进程(java)
* ps -ef | grep nginx | wc -l // 查看运行的进程总数
* ps -fu csvn // 查看特定进程(csvn)
* lsof -i :9000 // 查看端口执行的进程(9000)

## 网络
* ifconfig | grep inet // ip地址

## 传输
* wget {url} // 公网下载
* SCP: [SSH传输传输文件](http://blog.csdn.net/liuhongxiangm/article/details/17142611)
  * scp -P 22 -r localFilePath account@remoteIP:remoteFilePath // 上传，-P是SSH方的端口
  * scp -P 22 -r account@localIP:remoteFilePath localFilePath // 下载，-P是SSH方的端口
  * 注意，如目标路径后面是"/*"，则全部文件拷贝到目标路径根目录。
* sync -av --exclude excludePath /data/src/ /data/dest // 本地同步，排除文件夹(/data/src/excludePath)
* [远程同步](https://einverne.github.io/post/2017/07/rsync-introduction.html)
  * 语法：rsync 源端目录 目标端目录，如rsync -avz abc/ backup/abc，目标端目录不要加/否则会在下层再创建个目录abc
  * rsync -avz --delete /src_path account@host:/dest_path // 目标端"多则删之"，确保两个目录一致
  * rsync -avz --remove-source-files backup.tar /tmp/backups/ // 同步后自动删除源文件，使用场景是源文件每次都是个新文件

## 系统自启动配置
* 方法1：systemctl enable mysql
* 方法2：在文件/etc/rc.local加入命令，例如:
```
cd /var/www/project/ && /usr/bin/java -jar project.jar >/dev/null 2>&1 &
sh cmd.sh
/usr/local/redis/bin/redis-server /usr/local/redis/redis.conf &
service elasticsearch restart
service iptables stop
```
* [chkconfig命令](http://man.linuxde.net/chkconfig)
* [ Ubuntu下使用sysv-rc-conf管理服务](http://blog.csdn.net/gatieme/article/details/45251389)

## 远程免密码登录设置
* [远程免密码登录设置](http://www.2cto.com/os/201304/205141.html), https://blog.csdn.net/alifrank/article/details/48241699
* 说明
  1. 秘钥是服务器级别的。登录账号同秘钥，放在远程服务器的对应账号的authorized_keys里。如秘钥放在用户A的authorized_keys里，那只能用户A登录远程服务器。
  1. 如果authorized_keys设置了但还是无效，注意目录.ssh和文件authorized_keys的权限，确保登录账号有权限
* 步骤：在本地电脑通过ssh免密登录远程服务器
  1. 本地：生成公共密钥，用默认值。ssh-keygen -t rsa
  1. 公共密钥授权方案1
    本地：ssh-copy-id root@192.168.161.138
  1. 公共密钥授权方案2
    1. 本地：公共密钥上传到远程。scp ~/.ssh/id_rsa.pub root@192.168.161.138:/root/.ssh/id_rsa.tmp.pub
    1. 远程：将上传的本地公共密钥加到远程授权列表。cat ~/.ssh/id_rsa.tmp.pub>>~/.ssh/authorized_keys && rm ~/.ssh/id_rsa.tmp.pub
  1. 公共密钥授权方案3
    1. 本地：cat ~/.ssh/id_rsa.pub
    1. 远程：nano ~/.ssh/authorized_keys，将本地文本拷贝进去

* 一步本地操作：
```
cat ~/.ssh/id_rsa.pub | ssh root@192.168.161.138 "mkdir ~/.ssh; cat >> ~/.ssh/authorized_keys" // 同时创建目录.ssh
```

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
## 定时任务
1. 资料
  1. [使用方法](http://blog.chinaunix.net/uid-15007890-id-106828.html)
  1. [crontab编辑器](http://www.cronmaker.com/), [时间示例](https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/crontab.html)
  1. [语法](https://www.cnblogs.com/aminxu/p/5993769.html)
  1. [crontab不能执行git等命令](http://blog.csdn.net/gggxin/article/details/34434811)
  1. [UBUNTU开启CRONTAB日志记录及解决NO MTA INSTALLED, DISCARDING OUTPUT](https://blog.csdn.net/disappearedgod/article/details/43191693)
  1. [crontab不会缺省的从用户profile文件中读取环境变量参数，需要手工在脚本加载profile等文件](https://blog.csdn.net/weixin_36343850/article/details/79217611)，source /etc/profile
  1. [命令执行时间太长时防止多个并发运行](https://www.itdaan.com/tw/9d223190aa07c50d064b243281238c1f)
1. 安装：yum -y install crontab
1. 编辑：crontab -e

```
30 01 * * * sh /bin/backup.sys.sh // 每天1点30分
*/10 * * * * flock -xn ./tmp/abc.lock -c "/bin/abc.sh > /dev/null 2>&1" // 每隔10分钟，上一个如在运行则会取消本次执行
```

1. 重启：service crond restart
1. 查看执行结果：tail -f /var/log/cron
1. 调试方法
  1. 所有结果写到文件。如 sh xxx.sh &>/opt/debug.log
  1. 出错结果写到文件。如 sh xxx.sh > /opt/debug.log 2>&1

## 备份操作
* 被备份机
  1. 远程免密码登录设置(远程是备份机)
  1. 编写备份脚本，将其设置成定时任务。备份内容如配置文件，运营文件，数据库等
* 备份机：创建备份目录

## 安全
* [HTTPS证书转换成PEM格式](https://help.aliyun.com/document_detail/40526.html)
* openssl x509 -in mycert.crt -out mycert.pem -outform PEM // ssl的crt生成pem, der/crt是X.509的(ASCII), pem是X.509的(Base64)

## 杀毒
* [ClamAV](http://wiki.ubuntu.org.cn/ClamAV)
* 镜像网络
```
DatabaseMirror db.us.clamav.net
DatabaseMirror db.de.clamav.net
DatabaseMirror db.jp.clamav.net
```
## 压缩解压
* [资料](https://www.cnblogs.com/joshua317/p/6170839.html)
* -C PATH// 设置程序当前工作目录
* tar -rvf // 通过r追加文件，只能用于tar
* tar -tf a.tar.gz // 在不解压的情况下查看压缩包的内容

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

## FTP服务
* [SFTP安装-Ubuntu](https://www.digitalocean.com/community/tutorials/how-to-enable-sftp-without-shell-access-on-ubuntu-16-04)
* [docker pure-ftp 搭建ftp服务器](https://blog.csdn.net/sun1021873926/article/details/70175778)：无法启动
* 脚本

```
sudo adduser data
sudo mkdir -p /var/ftp/upload
sudo chown root:root /var/ftp
sudo chmod -R 755 /var/ftp
sudo chown data:data /var/ftp/upload
sudo nano /etc/ssh/sshd_config
在文件最后添加：
Match User data
ForceCommand internal-sftp
PasswordAuthentication yes
ChrootDirectory /var/ftp
PermitTunnel no
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no

sudo systemctl restart sshd
```

## 用户
* [用户和组](https://blog.csdn.net/MTbaby/article/details/52611423)
* [扩展用户管理](https://blog.csdn.net/PianoOrRock/article/details/79199317)
* sudo su // 用户切换到root。[Ubuntu中root用户和user用户的相互切换](https://www.cnblogs.com/weiweiqiao99/archive/2010/11/10/1873761.html)
* 用户启用sudo：需将账号加入到/etc/sudoers，user1 ALL=(ALL)NOPASSWD:ALL
* usermod -a -G groupA user1 // 用户user1添加到组groupA
* [linux下开启SSH，并且允许root用户远程登录,允许无密码登录](https://www.cnblogs.com/toughlife/p/5633510.html) : PermitEmptyPasswords yes

## 硬盘
* df // 硬盘容量
* du -sh path // 某一指定路径容量
* du . --max-depth=1 -h // 显示当前目录的空间容量
* du . --max-depth=1 -h | sort -nr // 顺序排序显示当前目录的空间容量
* df -ih // 索引文件情况
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

## nano
* ^C // 显示光标位置信息
* ctrl+w，ctrl-T // 到指定行

## 系统操作
* shutdown -h now // 关机
* reboot // 重启

## 审计log
/var/log/auth.log*

## 监控
* watch -n 1 -d 'ps -ef | grep java' // 每秒钟执行一次命令，定时执行

## ssh
* ssh -p port user@host  如：ssh -p 2222 pika@192.168.0.111
* [sshpass](https://www.cnblogs.com/mianbaoshu/p/9648241.html)
  * 命令带密码登录: sshpass -p "password" ssh -p 2222 pika@192.168.0.111
  * 密码文件生成: echo 'password' > mypasswd.txt
  * 命令带密码文件登录: sshpass -f mypasswd.txt ssh -p 2222 pika@192.168.0.111
  * 命令带密码文件SCP: sshpass -f mypasswd.txt scp -r -p 2222 pika@192.168.0.111:/opt/foo/ .

## diff
* diff -r dir1 dir2 // 目录比对
* diff -Naur dir1 dir2 // [linux 比较两个文件夹不同 (diff命令, md5列表)](https://www.cnblogs.com/xudong-bupt/p/6493903.html)
* [vimdiff](https://www.jianshu.com/p/0541a67c6d3f)

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

## 设置时间
* [Linux下的atime mtime ctime及如何用touch来修改](https://blog.csdn.net/qq_29503203/article/details/53862790)
```
find . -exec touch -d "2010-10-10 11:10:10" {} \; // 目录
touch -d "2010-05-31 08:10:30"  file_path // 文件
```

## 时间同步
* https://www.cnblogs.com/chenmh/p/5485829.html

```
ntpdate -u cn.pool.ntp.org // 同步网络时间服务器的时间
*/10 * * * * /usr/sbin/ntpdate time.nist.gov > /dev/null 2>&1 // 每隔10分钟同步时间

hwclock -r // 确定bios时间正确，不正确手工调整
hwclock -w // 写入正确时间到bios
hwclock --hctosys // bios时间同步到操作系统
```

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

## Ubuntu20.04
### 离线安装网络驱动
1. 下载[e1000e显卡驱动](https://downloadmirror.intel.com/15817/eng/e1000e-3.8.4.tar.gz)
1. [离线安装gcc和make以及网卡驱动](https://zhuanlan.zhihu.com/p/466440088)，注意内核模块加载前注意事项
    1. 需人工拷贝网卡驱动"cp /lib/modules/\${系统版本}/updates/drivers/net/ethernet/intel/e1000e/e1000e.ko /usr/lib/modules/\${系统版本}/kernel/net/wireless/"，[参考](https://zhuanlan.zhihu.com/p/470799941)

### 网络配置
* https://www.cnblogs.com/ubuntuanzhuang/p/13131138.html

## 加载Linux内核模块
* [modprobe命令](https://www.runoob.com/linux/linux-comm-modprobe.html)
* modprobe执行前注意事项
  1. 进入BIOS关闭secure boot。[参考](https://www.cnblogs.com/xuyaowen/p/linux-secure-boot-disable.html)
* lsmod | grep e1000e
* dmesg | grep e1000e
