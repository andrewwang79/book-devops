# ActiveMQ

# Ubuntu
* [安装](http://activemq.apache.org/getting-started.html)
```
wget https://www.apache.org/dist/activemq/5.14.1/apache-activemq-5.14.1-bin.tar.gz
tar -zxf apache-activemq-5.14.1-bin.tar.gz
cd apache-activemq-5.14.1/bin/linux-x86-64
```
* 如有Rabbitmq，则修改端口（其占用了端口5672）：nano conf/activemq.xml
* 启动
```
./activemq start
./activemq stop
```
* 检查
```
./activemq console
netstat -an | grep 61616
netstat -an | grep 8161
netstat -an | grep 5672
```
* 管理系统
  * http://IP:8161/admin/，默认账号密码：admin/admin
  * [设置密码](http://www.cnblogs.com/xiaxinggege/p/5900319.html)，设置好后需重启服务
* console管理：进入bin路径，sh activemq browse xyz // 查看queue xyz

# centos
* [7安装](http://www.cnblogs.com/zhi-leaf/p/5932011.html)
  * wget http://archive.apache.org/dist/activemq/5.15.0/apache-activemq-5.15.0-bin.tar.gz
  * 访问：网址: http://site:8161/admin/index.jsp。账号密码: admin/admin
* [6.5安装](http://blog.csdn.net/brushli/article/details/41694551)。
* 全部同Ubuntu。

# 参数
## 连接字符串
* tcp://0.0.0.0:61616?maximumConnections=1000&amp;wireFormat.maxFrameSize=104857600

## 端口对应协议
* 1883：mqtt
* 5672：amqp
* 8161：控台
* 61613：stomp
* 61614：ws
* **61616**：openwire
