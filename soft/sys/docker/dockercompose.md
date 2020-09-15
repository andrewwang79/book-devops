# docker-compose
* 是命令，不是服务，不需要先启动

## 命令
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
1. [Docker Compose 方式下的容器网络基础知识点](https://michael728.github.io/2019/06/15/docker-compose-networks)，https://docs.docker.com/compose/networking/
```
指定网络名，不设置name会是"当前目录_abc"
networks:
  abc:
    name: abcd
```
1. docker启动后不关闭的命令(docker无命令会自动关闭)：tail -f /dev/null
1. [语法](https://www.cnblogs.com/freefei/p/5311294.html)
1. [控制docker-compose中服务的启动顺序](https://blog.csdn.net/xiao_jun_0820/article/details/78676765)
```
depends_on:
  - "db"
command: ["./wait-for-it.sh", "db:3306", "--", "python", "app.py"]
```
