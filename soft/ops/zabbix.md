# Zabbix

## 概念和使用
| 名词 | 说明 |
|:--------:|--------|
| 主机 |  |
| 监控项 | 可自定义 |
| 触发器 | 监控项+条件 |
| 动作 | 触发器+操作 |
| 操作 | 三种：发生/恢复/确认。可发送到用户或者报警媒介 |
| 报警媒介 | 各种脚本，如钉钉群机器人 |

* [Zabbix容器使用触发器--动作--报警给邮箱等媒介](https://www.jianshu.com/p/eec230eedde5)
* [zabbix监控磁盘分区空间](https://blog.51cto.com/lookingdream/1834259)
* “键值”使用zabbix log函数的实例(取文件内的整数)：log[D:\abc.txt,"^(0|[1-9][0-9]*)$"]

## 资料
* https://www.jianshu.com/p/feffb24b08b2
* https://www.zabbix.com/documentation/3.4/zh/manual/installation/containers
* http://www.dockerinfo.net/3681.html

## docker安装
* 需先安装mysql

```
// 下载
sudo docker pull zabbix/zabbix-server-mysql
sudo docker pull zabbix/zabbix-web-apache-mysql
sudo docker pull zabbix/zabbix-agent

// 启用服务
sudo docker stop zabbix-web-apache-mysql && sudo docker rm zabbix-web-apache-mysql
sudo docker stop zabbix-server-mysql && sudo docker rm zabbix-server-mysql

sudo docker run --name zabbix-server-mysql -p 10051:10051 -e DB_SERVER_HOST="192.168.1.3" -e DB_SERVER_PORT="3306" -e MYSQL_USER="root" -e MYSQL_PASSWORD="123456" -v /etc/localtime:/etc/localtime -d zabbix/zabbix-server-mysql

sudo docker run --name zabbix-web-apache-mysql -p 9000:80 -e DB_SERVER_HOST="192.168.1.3" -e DB_SERVER_PORT="3306" -e MYSQL_USER="root" -e MYSQL_PASSWORD="123456" -e ZBX_SERVER_HOST="192.168.1.5" -v /etc/localtime:/etc/localtime -d zabbix/zabbix-web-apache-mysql

// 启用agent1
sudo docker stop zabbix-agent && sudo docker rm zabbix-agent
sudo docker run --name zabbix-agent -p 10050:10050 -e ZBX_HOSTNAME="192.168.1.88" -e ZBX_SERVER_HOST="192.168.1.5" -e ZBX_SERVER_PORT=10051 -v /etc/localtime:/etc/localtime -d zabbix/zabbix-agent

// 启用agent2
sudo docker stop zabbix-agent && sudo docker rm zabbix-agent
docker run --name zabbix-agent -p 10050:10050 -e ZBX_HOSTNAME="192.168.1.99" -e ZBX_SERVER_HOST="192.168.1.5" -e ZBX_SERVER_PORT=10051 -v /etc/localtime:/etc/localtime -d zabbix/zabbix-agent

// 运维命令
sudo docker exec -it zabbix-server-mysql /bin/bash
sudo docker exec -it zabbix-web-apache-mysql /bin/bash
sudo docker exec -it zabbix-agent /bin/bash

sudo docker logs zabbix-server-mysql
sudo docker logs zabbix-web-apache-mysql
```

## 使用
* web用户名及密码:Admin/zabbix

## 客户端安装使用
### 安装
* https://computingforgeeks.com/how-to-install-and-configure-zabbix-agent-3-4-on-centos-7/
* https://blog.51cto.com/shuzonglu/2097592
* 注意事项
```
yum install https://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-agent-3.4.15-1.el7.x86_64.rpm
客户端和服务端保持版本一直，不然可能会导致：message from IP is missing header. Message ignored.
```

### 使用
* https://zhuanlan.zhihu.com/p/35064593
```
nano /etc/zabbix/zabbix_agentd.conf
Server=172.16.17.211
ServerActive=172.16.17.211
Hostname=devops-cm
systemctl restart zabbix-agent.service
```
