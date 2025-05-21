# 常用
1. 重启网络服务
  * service network restart
  * service network reload
1. 从指定的文件加载系统参数，特别是网络参数
  * sysctl -p
1. [tcpdump-抓取网络数据包](http://blog.csdn.net/kobejayandy/article/details/17208137/)
  * tcpdump -i lo -nnA 'port 9020' // 监控本机回路网卡的9020端口
1. 端口侦测
  * telnet 192.168.0.168 12345
  * tcping64.exe 192.168.0.168 12345 [下载](https://elifulkerson.com/projects/tcping.php)

## 网络配置
* [ip](http://os.51cto.com/art/201406/441461.htm)
* mac=$(ip link show eth0 | awk '/ether/ {print $2}') //  获取网卡eth0的mac地址
* [ifconfig](http://blog.csdn.net/sdvch/article/details/12587515)
* ifconfig em 192.168.161.121/24 // 设置网卡
* ifconfig em down // 禁用网卡
* ifconfig | grep inet // ip地址
* nano /etc/sysconfig/network-scripts/ifcfg-em // 编辑网卡
* nano /etc/sysconfig/network // 设置网卡的永久网关
* nano /etc/network/interfaces && /etc/init.d/networking restartw // [设置DHCP，静态IP，DNS](http://forum.ubuntu.org.cn/viewtopic.php?f=73&t=190174)，
```
  iface ens33 inet static
  address 192.168.1.199
  gateway 192.168.1.1
  netmask 255.255.255.0
  dns-nameserver 8.8.8.8
```
* [Ubuntu20.04.2配置静态固定IP地址](https://blog.csdn.net/ARPOSPF/article/details/114293277)

# 路由/网关
* [资料](http://baike.baidu.com/link?url=3OWZNh6IVWlbyjsJIk41NClQT2ueZ8i3AQszfA_M8zTjP9GbZ77PdvA7xEQGCWY7vncnOD0jOy9jnKl20zCvH_)
* [设置](http://www.centoscn.com/CentOS/help/2014/0113/2351.html)
* [永久路由](http://blog.csdn.net/yuanchao99/article/details/18992567)
* 使用route 命令添加的路由，机器重启或者网卡重启后路由就失效
* route -n // 查看路由
* IP转发
  * nano /etc/sysctl.conf或者/etc/sysctl.d/99-sysctl.conf
  * 追加内容：net.ipv4.ip_forward = 1
* traceroute www.baidu.com // 路由跃点检查

# DNS
* [配置DNS服务](https://www.cnblogs.com/EasonJim/p/7857671.html)
```
echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
/etc/init.d/networking restart
```
* [linux绑定域名和IP](http://ttwang.iteye.com/blog/1955590)
```
echo "127.0.0.1 www.baidu.com" >> /etc/hosts
sudo /etc/init.d/networking restart
```

## netstat
  * netstat -lntp // 查看开启了哪些端口
  * netstat -r // 路由表的信息
  * netstat -an | grep ^tcp | grep 9050 | awk '{print $NF}' | sort -nr | uniq -c // 连接数统计
  * netstat -an | grep 8080 // 查看指定端口(8080)的所有的有效连接信息列表
  * netstat -an | grep -i listen // 目前系统侦听的所有端口
  * lsof -t -i :8080 // 查看占用了端口(8080)的进程

# 网桥
* [brctl](http://blog.csdn.net/x_nazgul/article/details/20233237)
* [配置](http://fp-moon.iteye.com/blog/1468650)

# 防火墙
* [iptables](http://blog.chinaunix.net/uid-26495963-id-3279216.html)
* [UFW是Ubuntu系统上配置iptables防火墙的工具](https://www.jianshu.com/p/1069fecb588a)

## 命令
* iptables -nvL INPUT // 查看定义规则的详细信息
* iptables -A INPUT -p tcp --dport 5672 -j ACCEPT // 接受5672端口的TCP访问。-A是添加到最后一个，-I是添加到第一个
* iptables -P INPUT ACCEPT // 默认策略
* iptables -D INPUT 1 // 删除第一个规则

## 资料
* [Linux(Ubuntu) iptables使用小记](https://0x1.im/blog/server/use-linux-ubuntu-iptables.html)
* [命令](https://wangchujiang.com/linux-command/c/iptables.html)
* [常用套路](http://www.zsythink.net/archives/1869)
* [配置参考](https://codeday.me/bug/20181124/405722.html)
* [域名解析中的cname解析和显性URL跳转和隐性URL跳转](https://blog.csdn.net/qq_26291823/article/details/75090094)

## 常用配置
```
iptables -I INPUT -p tcp -m multiport --dport 4000 -j ACCEPT
iptables -I INPUT -p tcp -m multiport --dport 22,80 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT // 已建立的连接
iptables -A INPUT -i lo -j ACCEPT // loopback
iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT // enable ping
iptables -A INPUT -j REJECT
iptables -A OUTPUT -j ACCEPT
```

# 报文发送
* [CURL命令](https://blog.csdn.net/huangzx3/article/details/80625080)
* [做Http的Get/Post请求](https://www.jianshu.com/p/a8b648e96753)
* [使用curl和wget发送json格式的post请求](https://blog.csdn.net/xcc_2269861428/article/details/83345351)

```
-s 静默
-i 返回结果包括报文头
curl -H "Content-type: application/json" -H 'token:abc123' -X POST -d '{"phone":"13521389587","password":"test"}' http://domain/api/v1/user.login
```

# 网络监控
* [Linux服务器上监控网络带宽的18个常用命令](https://blog.csdn.net/yygydjkthh/article/details/75269537)：iftop
* [mtr](https://docs.ucloud.cn/unet/troubleshooting)

```
tcpdump
iftop：https://www.vpser.net/manage/iftop.html，https://www.cnblogs.com/chenqionghe/p/10680075.html
iftop -BP -i eth0 -F 192.168.85.0/24

监控总体带宽使用――nload、bmon、slurm、bwm-ng、cbm、speedometer和netload
监控总体带宽使用（批量式输出）――vnstat、ifstat、dstat和collectl
每个套接字连接的带宽使用――iftop、iptraf、tcptrack、pktstat、netwatch和trafshow
每个进程的带宽使用――nethogs
```

# netcat
* [网络工具netcat](https://www.runoob.com/linux/linux-comm-nc.html)

```
nc -nvz example.com 20-80 // 端口扫描
```

# TIME_WAIT
1. [解决TIME_WAIT过多造成的问题](https://www.cnblogs.com/dadonggg/p/8778318.html)
1. [TIME_WAIT和CLOSE_WAIT状态区别](https://blog.csdn.net/kobejayandy/article/details/17655739)
1. [阿里云服务出现TCP连接快速增加尤其是NON_ESTABLISHED大量增加导致内存和CPU暴增系统无法使用的问题](https://www.cnblogs.com/peteremperor/p/10882076.html)
1. [TCP的状态迁移](https://qiuzhenyuan.github.io/2018/01/28/TCP%E7%9A%84%E7%8A%B6%E6%80%81%E8%BF%81%E7%A7%BB/)
1. [/etc/sysctl.conf的内核参数](http://www.iocoder.cn/Nginx/Based-on-Nginx-to-achieve-100000-concurrency-Linux-kernel-optimization/?vip)
  1. ss -s
  1. 不同状态的连接数数量：netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
  1. 每个ip跟服务器建立的连接数：netstat -nat|grep "tcp"|awk ' {print$5}'|awk -F : '{print$1}'|sort|uniq -c|sort -rn

```
nano /etc/sysctl.conf

net.core.somaxconn = 2000
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_fin_timeout = 30
```

# 代理
## Squid(Linux上的HTTP代理服务端)
>Squid服务是构建在Linux网关主机上的，正确设置防火墙策略，将局域网主机访问Internet的数据包转交给Squid进行处理。用到iptables的REDIRECT（重定向）策略。实现本机端口的重新定向，将访问网站协议HTTP、HTTPS的外发数据包转发交给本机的Squid服务（3128端口）
## 服务端安装
1. 服务端安装Squid(https://blog.csdn.net/qy20115549/article/details/83375817)。使用正向代理，默认代理端口是3128
1. 确保服务端开放服务端的防火墙
1. 客户端设置代理IP

### 资料
* 服务端
  * [Windows下Squid 3.5安装及配置代理服务器](https://blog.csdn.net/qy20115549/article/details/83375817)
  * [squid代理服务器安装配置指南](https://zhuanlan.zhihu.com/p/32291921)
  * [Squid透明代理的配置](https://blog.51cto.com/wangfeiyu/2072663)

## proxychains4(Linux上的代理客户端)
* [proxychains4配置使用](https://www.cnblogs.com/mwq1024/p/11582003.html)
```
apt install proxychains4
echo "socks5 10.71.10.49 12306" >> /etc/proxychains4.conf
proxychains4 curl www.httpbin.org/ip
```

## Windows的CMD窗口的网络代理配置
* 执行：set HTTP_PROXY=http://127.0.0.1:10809 && set HTTPS_PROXY=http://127.0.0.1:10809
* 验证：curl https://www.github.com

# VNC
* 服务器有TightVNC、RealVNC、[TigerVNC](https://tigervnc.org)
* 服务端安装：sudo apt install tigervnc-standalone-server
```
vncserver :2
vncserver -geometry 1280x720
vncserver -list
```
* 客户端安装：vncviewer.exe

# FTP服务
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
