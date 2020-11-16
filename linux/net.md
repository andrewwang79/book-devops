# 常用
1. [ip](http://os.51cto.com/art/201406/441461.htm)
1. [ifconfig](http://blog.csdn.net/sdvch/article/details/12587515)
1. netstat
  * netstat -lntp // 查看开启了哪些端口
  * netstat -r // 路由表的信息
  * netstat -an | grep ^tcp | grep 9050 | awk '{print $NF}' | sort -nr | uniq -c // 连接数统计
  * netstat -an | grep 8080 // 所有的有效连接信息列表(8080)
  * netstat -an | grep -i listen // 目前系统侦听的端口号
  * netstat -anp | grep 8080 // 查看哪个进程占用了端口(8080)

1. 网卡
  * ifconfig em 192.168.161.121/24 // 设置网卡
  * ifconfig em down // 禁用网卡
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
1. 重启网络服务
  * service network restart
  * service network reload
1. 从指定的文件加载系统参数，特别是网络参数
  * sysctl -p
1. [tcpdump-抓取网络数据包](http://blog.csdn.net/kobejayandy/article/details/17208137/)
  * tcpdump -i lo -nnA 'port 9020' // 监控本机回路网卡的9020端口
1. traceroute www.baidu.com -路由跃点检查
1. [linux绑定域名和IP](http://ttwang.iteye.com/blog/1955590)

# [路由](http://baike.baidu.com/link?url=3OWZNh6IVWlbyjsJIk41NClQT2ueZ8i3AQszfA_M8zTjP9GbZ77PdvA7xEQGCWY7vncnOD0jOy9jnKl20zCvH_)
* [设置](http://www.centoscn.com/CentOS/help/2014/0113/2351.html)
* [永久路由](http://blog.csdn.net/yuanchao99/article/details/18992567)
* 使用route 命令添加的路由，机器重启或者网卡重启后路由就失效
* route -n // 查看路由
* IP转发
  * nano /etc/sysctl.conf或者/etc/sysctl.d/99-sysctl.conf
  * 追加内容：net.ipv4.ip_forward = 1

# [网桥(brctl)](http://blog.csdn.net/x_nazgul/article/details/20233237)
* [配置](http://fp-moon.iteye.com/blog/1468650)

# [防火墙(iptables)](http://blog.chinaunix.net/uid-26495963-id-3279216.html)
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

# DNS
* [配置DNS服务](https://www.cnblogs.com/EasonJim/p/7857671.html)
* 增加DNS映射关系
```
sudo nano /etc/hosts
  127.0.0.1 www.baidu.com
sudo /etc/init.d/networking restart
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
