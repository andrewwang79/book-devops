# Redis

## 命令
  * [redis开启远程访问](http://www.cnblogs.com/liusxg/p/5712493.html)
  * 重新加载配置文件：redis-server /etc/redis.conf
  * 启动：service redis start。/usr/local/redis/bin/redis-server /usr/local/redis/redis.conf &
  * 版本：redis-server -v

## 客户端命令
  * 本机无密登录：redis-cli
  * 本地密码登录：redis-cli -a 密码
  * 远程登录：redis-cli -a 密码 -h 主机名
  * 设置密码
  ```
  config set requirepass %pwd%
  auth %pwd%
  ```
  * 切换db：select 2
  * key数量：dbsize
  * 获取数据：get {key}
  * 是否存在：exists {key}
  * 显示匹配的key：keys *
  * 删除数据：del key xyz
  * 删除db的数据: flushdb
  * 删除所有数据: flushall

## 资料
* [最大连接数查询与设置](https://www.cnblogs.com/zt007/p/9510795.html)：info clients
