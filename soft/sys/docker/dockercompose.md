# docker-compose
* 是命令，不是服务，不需要先启动

## 命令
* 资料: https://yeasy.gitbook.io/docker_practice/compose/commands, https://www.kancloud.cn/panpan_w/panpan_w/718250
1. 启动
docker-compose up -d
1. 停止
docker-compose stop
1. 强制删除(动态扩展的容器也可以一并删除)
docker-compose rm -f
1. 查看指定compose文件对应的容器清单和状态
docker-compose ps

## 示例
```
version: '3.5'
services:
  XX-network-redis:
    image: redis
    restart: always
    container_name: XX-network-redis
    ports:
      - "27379:6379"
    volumes:
      - /etc/localtime:/etc/localtime:ro
    networks:
      - XX-network
networks:
  XX-network:
    name: XX-network
    driver: bridge
```
## 资料
* [compose-file-v3](https://docs.docker.com/compose/compose-file/compose-file-v3/)
1. [语法](https://www.cnblogs.com/freefei/p/5311294.html)

## 使用
1. 环境变量
  * https://www.jianshu.com/p/c87d4031413c
  * https://zhuanlan.zhihu.com/p/55486428
  * https://segmentfault.com/a/1190000023655147
```
定义变量：
export DB_PORT=3306 && export DB_IP=111 && docker-compose config
DB_PORT=3306 DB_IP=111 docker-compose config
使用：
${nginx_port}:80
${nginx_port-81}:80 // -后面是默认值
```
  * serviceName和networkName定义不能动态，用envsubst解决

1. [Docker Compose 方式下的容器网络基础知识点](https://michael728.github.io/2019/06/15/docker-compose-networks)，https://docs.docker.com/compose/networking/
```
指定网络名，不设置name会是"当前目录_abc"
networks:
  abc:
    name: abcd
    driver: bridge
```
1. docker启动后不关闭的命令(docker无命令会自动关闭)
```
// 方案1，命令挂起。有时候sh无效，原因未知
command: sh -c "tail -f /dev/null"
// 方案2，外挂挂起文件。有时候sh无效，原因未知
volumes:
  - ./:/opt/xxx/
command: ["/opt/xxx/hang.sh"]
hang.sh
#!/bin/bash
tail -f /dev/null
// 方案3，1和2组合
command: sh -c "sh /opt/xxx/hang.sh"
```
1. [控制docker-compose中服务的启动顺序](https://blog.csdn.net/xiao_jun_0820/article/details/78676765)
```
depends_on:
  - "db"
command: ["./wait-for-it.sh", "db:3306", "--", "python", "app.py"]
```
1. 进程优先级
```
命令如下：优先级最低-20
renice -10 4753 // renice [优先级] PID
nice -n -5 service httpd start // nice [-n NI值] 命令
docker-compose使用方法：
cap_add:
     - SYS_NICE
```
1. CPU资源限制
* https://www.cnblogs.com/sparkdev/p/8052522.html。docker支持的--cpu-shares，不能在docker-compose使用。docker-compose只支持绝对值
* 测试方法：stress -c 2
* docker-compose协议3的
```
nano docker-compose.yml && docker-compose --compatibility up -d // docker-compose版本低于1.27需加--compatibility【不建议生产环境使用】
version: "3.7"
services:
  s1:
    image: redis:latest
    container_name: s1
    deploy:
      resources:
        limits:
          cpus: '2.50'
        	memory: 1G
        	memory-swap: -1
    command: sh -c "tail -f /dev/null"
  s2:
    image: redis:latest
    container_name: s2
    deploy:
      resources:
        limits:
          cpus: '1.20'
        	memory: 1G
      	reservations:
        	memory-swap: -1
    command: sh -c "tail -f /dev/null"
```
* docker-compose协议2的，交换内存配置项测试下来是无效的，原因未知
```
version: "2.4"
services:
  s1:
  mem_limit: 4M
  mem_swappiness: 10
  memswap_limit: 8M
```
