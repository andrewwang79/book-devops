# MySQL

## 资料
1. [MySQL 双机热备配置步骤](https://www.zybuluo.com/Spongcer/note/69119)
1. [使用Nginx+Keepalived组建高可用负载平衡Web server集群](http://blog.csdn.net/luxiaoyu_sdc/article/details/7333024)
1. 默认日志目录：/var/lib/mysql/
1. [max_allowed_packet设置](http://www.cnblogs.com/yeahgis/archive/2012/03/16/2399985.html),过小导致写入失败
1. set global log_bin_trust_function_creators=1;
1. [JDBC查询条件输入中文，查询为空](http://www.it610.com/article/1824094.htm)：String url = "jdbc:mysql://127.0.0.1:3306/mydata?useUnicode=true&characterEncoding=utf-8";
1. [MySQL Workbench的安全更新模式](http://www.cnblogs.com/zgqys1980/p/4129239.html)：SET SQL_SAFE_UPDATES=0;
1. [mysql max_allowed_packet自动重置为1024 终结解决](http://www.cnblogs.com/qdpurple/p/5742059.html)，查询max_allowed_packet重置的日志，日志文件是“general_log_file”
1. [不区分大小写，默认是区分大小写的](http://blog.csdn.net/tengdazhang770960436/article/details/53337338)
  1. nano /etc/my.cnf
  1. 在[mysqld]节点下，加入一行： lower_case_table_names=1
1. 开放外部访问
```
// mysql的root账户放开访问限制。注意把pwd改成当前密码
mysql -u root -p
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '密码' WITH GRANT OPTION; FLUSH PRIVILEGES; EXIT;
# 关闭防火墙
systemctl stop firewalld.service #停止firewall
systemctl disable firewalld.service #禁止firewall开机启动
```
1. 保存时中文乱码的解决
  * [Mysql数据库的中文乱码问题分析](http://blog.csdn.net/blueheart20/article/details/52385142)
  * 两种方法
    * 找原因调整：如修改配置文件(/etc/my.cnf)，增加一行“character-set-server = utf8”
    * 强制设置：连接字符串设置成“mysql://${ip}:3306/${db_name}?useUnicode=true&characterEncoding=utf-8”
1. 日志
    1. [MySQL日志分析](http://homeway.me/2015/09/12/mysql-log/)
    1. [日志general-log的开启和分析方法](http://blog.51cto.com/arthur376/1853924)
1. [整理Mysql "Too many connections" 解决办法](https://blog.csdn.net/q549244663/article/details/78205247)
1. [生产环境中MySQL Drop 删除(百G级、T级)大表的解决方法](http://www.jiagoumi.com/work/1487.html)

### binlog
#### 启用
```
mysql.cnf
  server-id = 1
  log_bin = /var/log/mysql/mysql-bin.log
  max_binlog_size = 1000M
  binlog-format = row

docker启用需要修改路径权限，如chgrp -R docker . && chown -R 999 .
```
#### 使用
```
mysql回滚到指定时间点: http://static.kancloud.cn/ichenpeng/blog/1514019
闪回(delete部分): https://www.cnblogs.com/gered/p/10765749.html#autoid-3-2-0
看 mysqlbinlog mysql-bin.000003 -v
```

### 主从
```
mysql.cnf master
  server-id = 2
  log_bin = mysql-bin
mysql.cnf slave
  server-id = 2
  log_bin = mysql-bin
  read_only=1
  log_slave_updates=1
```

* https://www.jianshu.com/p/b0cf461451fb
* http://static.kancloud.cn/ichenpeng/blog/1134189
* 错误处理: https://blog.51cto.com/suifu/1845114

## 管理命令
1. 启动：service mysql restart
1. 登录客户端：mysql -u{account} -p{pwd} -h{ip} -P{port}。如mysql -uroot -p123123 -h192.168.1.10 -P3311
1. [新建mysql备份账号](http://blog.csdn.net/wengyupeng/article/details/3290415)
  1. 登录
  1. 授权
  ```
  GRANT LOCK TABLES, SELECT ON *.* TO ba@localhost IDENTIFIED BY '123123';
  ```
1. 备份
  1. 备份：mysqldump -uba -p123123 dbName > dbName.db
  1. 恢复(2种)
    * 系统命令：mysql -uba -p123123 dbName < dbName.db
    * mysql控制台：mysql> use xyz;source /path/xyz.db;
* UTF8的数据库创建：CREATE DATABASE `db1` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

## SQL命令
* 修改账号密码
```
use mysql;
UPDATE user SET authentication_string=PASSWORD('123123') where USER='root';
FLUSH PRIVILEGES;
```
* 显示变量：SHOW VARIABLES LIKE 'max_allowed_%';
* 显示所有数据库：show databases;
* 选择数据库：use {database};
* 显示所有表：show tables;
* 删除非系统的表（被黑了用）
```
SELECT CONCAT( 'DROP TABLE ', GROUP_CONCAT(table_name) , ';' ) AS statement
FROM information_schema.tables WHERE table_schema = 'mysql' AND table_name NOT IN
('columns_priv','db','event','func','general_log','help_category','help_keyword','help_relation','help_topic','host','ndb_binlog_index','plugin','proc','procs_priv','proxies_priv','servers','slow_log','tables_priv','time_zone','time_zone_leap_second','time_zone_name','time_zone_transition','time_zone_transition_type','user');
```
* 查询系统用户
```
use mysql;
select user,host from user;
```
* 显示表结构 : DESC {table_name};
* 显示表索引 : SHOW INDEX FROM {table_name};
* 删除表索引 :
```
ALTER TABLE {table_name}
DROP INDEX {column};
```
* 查询所有表的记录数量
```
select concat('select "', TABLE_name, '", count(*) from ', TABLE_SCHEMA, '.', TABLE_name, ' union all') from information_schema.tables where TABLE_SCHEMA='20191024_huadong_ring_server';
```

## 安装
* [安装](http://www.cnblogs.com/jerrylz/p/5645224.html)
* [ubuntu下彻底卸载mysql后重新安装](https://blog.csdn.net/chudongfang2015/article/details/52154903)

## 知识
1. [我必须得告诉大家的MySQL优化原理 - 知乎](https://zhuanlan.zhihu.com/p/63671792)
1. [﻿从 MySQL 执行原理告诉你：为什么分页场景下，请求速度非常慢](https://youyou-tech.com/2019/12/08/%E4%BB%8EMySQL%E6%89%A7%E8%A1%8C%E5%8E%9F%E7%90%86%E5%91%8A%E8%AF%89%E4%BD%A0%EF%BC%9A%E4%B8%BA%E4%BB%80%E4%B9%88%E5%88%86%E9%A1%B5%E5%9C%BA/)

### 性能
1. 数据统计
  * [MysqlWorkBench性能分析工具--性能仪表盘](https://www.jianshu.com/p/bb42f18ae5c3),特别是耗时sql清单
1. 慢查询
  * [Mysql监控执行速度慢的语句](http://www.2cto.com/database/201304/201668.html)
```
show variables like 'log_slow_queries';
show variables like 'long_query_time';
show variables like 'slow_query_log_file';
SET GLOBAL log_slow_queries = ON;
SET GLOBAL long_query_time = 1;
```
1. [查看mysql正在执行的SQL语句](https://www.iteye.com/blog/qq85609655-2113960)
select * from information_schema.PROCESSLIST where info is not null; // show processlist;
1. [Mysql性能优化神器Explain使用](https://c.m.163.com/news/a/F2SAA50I0517P77J.html﻿)
1. [MySQL CPU 使用率高的原因和解决方法](https://blog.csdn.net/u011239989/article/details/72863333)

### 四种事务隔离级的说明
* [四种事务隔离级的说明](https://www.cnblogs.com/zhoujinyi/p/3437475.HTML)
* 语句实践
```
drop TABLE `t_txtest`;
CREATE TABLE `t_txtest` (
`id` bigint(20) NOT NULL default '0',
`value` varchar(32) default NULL,
PRIMARY KEY (`id`)
) ENGINE=InnoDB
set session transaction isolation level read uncommitted;
START TRANSACTION;
SELECT * FROM t_txtest;
INSERT INTO t_txtest VALUES (1, 'a');
commit;
```
