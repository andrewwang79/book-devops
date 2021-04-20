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
// 方案1，命令挂起，有时候sh无效，原因未知
command: sh -c "tail -f /dev/null"

// 方案2，外挂挂起文件，有效
volumes:
  - ./:/opt/xxx/
command: ["/opt/xxx/hang.sh"]
hang.sh
#!/bin/bash
tail -f /dev/null
```
1. [语法](https://www.cnblogs.com/freefei/p/5311294.html)
1. [控制docker-compose中服务的启动顺序](https://blog.csdn.net/xiao_jun_0820/article/details/78676765)
```
depends_on:
  - "db"
command: ["./wait-for-it.sh", "db:3306", "--", "python", "app.py"]
```
