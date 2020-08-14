# RabbitMQ

* [官网](http://www.rabbitmq.com/)

# centos
* [安装](http://www.blogjava.net/hellxoul/archive/2014/06/25/415135.html)

```
1. rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
2. yum install erlang
3. wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.3.4/rabbitmq-server-3.3.4-1.noarch.rpm
4. yum install rabbitmq-server-3.3.4-1.noarch.rpm
--------3.6.5-1的rabbitmq，对应epel没找到
yum install rabbitmq-server-3.6.5-1.noarch.rpm
5. service rabbitmq-server start
```

# Ubuntu
* [安装](http://blog.sina.com.cn/s/blog_77c35cff01011vsz.html)，apt安装，部分命令调整如下：
```
wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo apt-key add rabbitmq-signing-key-public.asc
```

# [web管理系统安装](http://blog.csdn.net/heybob/article/details/20540189)
* 端口55672其实是15672
```
iptables -A INPUT -p tcp --dport 5672 -j ACCEPT
iptables -A INPUT -p tcp --dport 15672 -j ACCEPT
```
* /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management
* /etc/init.d/rabbitmq-server restart
* netstat -ntlp |grep 15672
* http://IP:15672/

# [账号管理和角色分配](http://www.cnblogs.com/mingaixin/p/4134920.html)
* rabbitmqctl add_user account password
* rabbitmqctl set_user_tags account administrator
* rabbitmqctl set_permissions -p / account '.*' '.*' '.*'
