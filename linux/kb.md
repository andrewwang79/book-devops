# 系统知识
* [Linux命令大全](https://man.linuxde.net/)

## 系统操作
* shutdown -h now // 关机
* reboot // 重启

## CentOS
1. [Centos7 系统优化](https://www.jianshu.com/p/0a06b306449a)
1. 安装chrome浏览器：rpm -i https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

## Ubuntu
1. [安装桌面版](https://ubuntu.com/tutorials/install-ubuntu-desktop)
1. [Shell重定向](https://blog.csdn.net/u011630575/article/details/52151995)

## 软件安装卸载
| 安装方式 | CentOS | Ubuntu |
| -- | -- | -- |
| 离线 | rpm安装: rpm -ivh xxx.rpm | dpkg安装卸载deb文件: dpkg --install  xxx.deb <br> [ubuntu的deb安装包](http://archive.ubuntu.com/ubuntu/pool/) |
| 在线 | yum | apt-get |

* ls -tl /var/lib/dpkg/info/*.list | head -n 10 // 查看最近安装的10个deb
* alien package_name.rpm // RPM转成DEB

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

* [清华的sources.list制作](https://mirrors.tuna.tsinghua.edu.cn/help/ubuntu/)
* [Ubuntu16.04更换阿里云apt-get软件源](https://blog.csdn.net/yjk13703623757/article/details/79860133)
    * sed -i 's#http://cn.archive.ubuntu.com#https://mirrors.163.com#g' /etc/apt/sources.list
    * sed -i 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list
* [ubuntu 20.04 设置国内镜像源](https://blog.csdn.net/MacWx/article/details/137689898)
* [Ubuntu离线安装软件包](https://blog.csdn.net/nupt123456789/article/details/11649603)
* [apt-get安装出现dpkg status database is lock解决](http://www.2cto.com/os/201305/208284.html)，安装失败会导致其他软件不能使用，比如MySQL
```
    rm /var/lib/dpkg/lock
    dpkg --configure -a    
```

* [大量dpkg依赖错误](https://segmentfault.com/q/1010000000117928)

### 离线安装
* [官方安装包实例-docker](https://docs.docker.com/install/linux/docker-ce/binaries/#install-static-binaries)
* [第三方yum缓存工具](https://blog.csdn.net/Post_Yuan/article/details/79449175)
* [自己做yum缓存包](https://blog.csdn.net/bbg221/article/details/78360618)

### 软件安装
#### ffmpeg
1. ffmpeg -version
1. centos：https://www.jianshu.com/p/11a3e9c91c38
1. debian：apt update && apt-get install -y ffmpeg

#### chrome
1. google-chrome --version
1. centos：yum install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
1. Ubuntu：wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && dpkg -i google-chrome-stable_current_amd64.deb && rm -f google-chrome-stable_current_amd64.deb

### Ubuntu20.04
#### 离线安装网络驱动
1. 下载[e1000e显卡驱动](https://downloadmirror.intel.com/15817/eng/e1000e-3.8.4.tar.gz)
1. [离线安装gcc和make以及网卡驱动](https://zhuanlan.zhihu.com/p/466440088)，注意内核模块加载前注意事项
    1. 需人工拷贝网卡驱动"cp /lib/modules/\${系统版本}/updates/drivers/net/ethernet/intel/e1000e/e1000e.ko /usr/lib/modules/\${系统版本}/kernel/net/wireless/"，[参考](https://zhuanlan.zhihu.com/p/470799941)

#### 网络配置
* https://www.cnblogs.com/ubuntuanzhuang/p/13131138.html

## 系统信息
* lsb_release -a // Ubuntu系统版本
* last reboot // 重启记录
* [Linux上如何查看物理CPU个数，核数，线程数](https://www.cnblogs.com/ivictor/p/6208573.html)
* cat /proc/cpuinfo |grep MHz|uniq // 查看CPU内核频率
* sudo dmidecode -s processor-version // 查看CPU型号

## 环境变量
* 环境变量永久新增方法：文件追加行，如export path=$path:/path1:/pahtN
  * 于/etc/profile文件：对所有用户生效(永久的)
  * 用户目录下的.bash_profile文件，对单一用户生效(永久的)
* 环境变量在当前session的新增方法：export HELLO="Hello!"
* readonly TEST // 将环境变量TEST设为只读
* source /etc/profile // 人工重新加载和生效文件
* echo $HOME // 显示环境变量HOME
* env // 显示所有的环境变量

## 脚本及启动机制
1. 脚本
  1. /etc/profile // 系统+登录
  1. $HOME/.profile // 用户+登录
  1. $HOME/.bashrc // 用户+非登录
1. 启动机制
  1. 先跑系统的，再跑用户的
  1. 先跑bashrc，再跑profile(登录状态)

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

## 系统日志
* (journal日志](https://www.cnblogs.com/jiuchongxiao/p/9222953.html)
* 审计log : /var/log/auth.log*

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

## 加载Linux内核模块
* [modprobe命令](https://www.runoob.com/linux/linux-comm-modprobe.html)
* modprobe执行前注意事项
  1. 进入BIOS关闭secure boot。[参考](https://www.cnblogs.com/xuyaowen/p/linux-secure-boot-disable.html)
* lsmod | grep e1000e
* dmesg | grep e1000e

## 局域网时间同步配置(chrony)
* 动态同步，几分钟到几小时。Windows客户端可以支持
* 以下命令在server和client都需运行
```
apt install chrony
systemctl stop systemd-timesyncd
systemctl disable systemd-timesyncd
```

### server操作
```
nano /etc/chrony/chrony.conf
  allow 192.168.1.0/24
  allow all
systemctl restart chrony
```

### client操作
```
nano /etc/chrony/chrony.conf
  去掉pool
  server 192.168.1.135 iburst minpoll 6 maxpoll 10
systemctl restart chrony
```

### 命令和同步执行确认
1. 确认client正常工作
```
chronyc sources：确认状态不是“^?” // 确认已连到server
chronyc tracking：确认“Ref time (UTC)”是现在 // 确认已执行过同步
```

1. 手动发起同步
```
chronyc -a 'burst 4/4' // 进行四次测量，并在每次测量之间等待间隔时间
chronyc -a makestep // 立即调整系统时间，无论差异有多大
```

## 杀毒
* [ClamAV](http://wiki.ubuntu.org.cn/ClamAV)
* 镜像网络
```
DatabaseMirror db.us.clamav.net
DatabaseMirror db.de.clamav.net
DatabaseMirror db.jp.clamav.net
```

## 定时任务
* 资料
    1. [使用方法](http://blog.chinaunix.net/uid-15007890-id-106828.html)
    1. [crontab编辑器](http://www.cronmaker.com/), [时间示例](https://linuxtools-rst.readthedocs.io/zh_CN/latest/tool/crontab.html)
    1. [语法](https://www.cnblogs.com/aminxu/p/5993769.html)
    1. [crontab不能执行git等命令](http://blog.csdn.net/gggxin/article/details/34434811)
    1. [UBUNTU开启CRONTAB日志记录及解决NO MTA INSTALLED, DISCARDING OUTPUT](https://blog.csdn.net/disappearedgod/article/details/43191693)
    1. [crontab不会缺省的从用户profile文件中读取环境变量参数，需要手工在脚本加载profile等文件](https://blog.csdn.net/weixin_36343850/article/details/79217611)，source /etc/profile
    1. [命令执行时间太长时防止多个并发运行](https://www.itdaan.com/tw/9d223190aa07c50d064b243281238c1f)
* 编辑：crontab -e

```
注意sh文件必须有执行权限，否则不会执行。赋予权限：chmod +x xxx.sh
30 01 * * * sh /bin/xxx.sh >> /tmp/xxx.log 2>&1 // 每天1点30分
*/10 * * * * flock -xn ./tmp/xxx.lock -c "/bin/xxx.sh >> /dev/null 2>&1" // 每隔10分钟，上一个如在运行则会取消本次执行
```

* 重启：service crond restart
* 查看执行结果：tail -f /var/log/cron
* 调试方法
    * 所有结果写到文件。如 sh xxx.sh >>/opt/debug.log
    * 出错结果写到文件。如 sh xxx.sh >> /opt/debug.log 2>&1

## 备份操作
* 被备份机
  1. 远程免密码登录设置(远程是备份机)
  1. 编写备份脚本，将其设置成定时任务。备份内容如配置文件，运营文件，数据库等
* 备份机：创建备份目录

## 远程桌面
* [Ubuntu桌面系统开启远程桌面](https://lakhanisiddharth94.medium.com/remote-access-of-ubuntu-from-windows-using-tightvnc-viewer-e6cbd9616733)