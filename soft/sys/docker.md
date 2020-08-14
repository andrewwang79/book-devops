# Docker

## 安装
* [CentOS](https://docs.docker.com/install/linux/docker-ce/centos/)
* [Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

## 资料
### 重要
1. Docker基于Linux内核提供的cgroups功能，可以限制容器在运行时使用到的资源，比如内存、CPU、I/O、网络等
1. Docker的集装箱原则：将代码或文件拆分出container，放到宿主机(container通过卷组映射来读取)，违背了原则。
1. image是镜像，container是容器，有id和name
1. [Docker — 从入门到实践](https://yeasy.gitbooks.io/docker_practice/)，推荐教程和手册
1. [官方命令集](https://docs.docker.com/reference/)
1. [重要命令](http://blog.csdn.net/u013246898/article/details/52987605)
1. [命令](http://www.cnblogs.com/niloay/p/6259436.html)
1. Docker日志
  1. [Docker日志: 引擎/容器](https://www.cnblogs.com/YatHo/p/7866029.html)
  1. [Docker容器日志查看与清理](https://blog.csdn.net/yjk13703623757/article/details/80283729)
  1. [docker容器log日志过大问题](https://blog.csdn.net/weixin_39600057/article/details/85146311)：/etc/docker/daemon.json

### 其他
* [官网](https://www.docker.com/)
* [Docker入门实战](http://yuedu.baidu.com/ebook/d817967416fc700abb68fca1?pn=1)
* [docker——容器安装tomcat](http://www.cnblogs.com/niloay/p/6259650.html)
* [ActiveMQ](http://blog.csdn.net/metar_he/article/details/56674598)
* [修改docker时区](http://blog.csdn.net/u012373815/article/details/52782807)
* [免sudo使用docker命令](http://blog.csdn.net/baidu_36342103/article/details/69357438)
* [Docker - 国内镜像的配置及使用](https://www.cnblogs.com/anliven/p/6218741.html)
* [配置私有仓库(使用registry镜像搭建一个私有仓库)](http://www.cnblogs.com/wade-luffy/p/6590849.html)
* [ubuntu的docker上Couldn't connect to Docker daemon at http+unix://var/run/docker.sock](https://blog.csdn.net/qiyueqinglian/article/details/46559825)
* [Docker with Spring Boot](https://www.jianshu.com/p/6a1b06ab8734)
* [Docker 修改默认存储位置](https://www.jianshu.com/p/5a2ff266b6e9)
* [修改桥接IP(解决和宿主机网段冲突)](https://blog.csdn.net/lin521lh/article/details/78470732)
* [获取 docker 容器(container)的 ip 地址](https://blog.csdn.net/sannerlittle/article/details/77063800)

## 操作
### 修改Docker默认存储位置
http://blog.51cto.com/forangela/1949947

```
service docker stop
mv /var/lib/docker /data/docker
ln -s /data/docker /var/lib/docker
service docker start
```

### registry配置
* [Docker](https://hub.docker.com/)
* [阿里云](https://dev.aliyun.com/search.html)
* 自己的：docker pull qiya365/XXX
* 修改仓库方法
```
/etc/docker/daemon.json 添加registry-mirrors
{
  "registry-mirrors":["https://hub-mirror.c.163.com","https://docker.mirrors.ustc.edu.cn","https://registry.docker-cn.com"]
}
重启docker
```

### 内存使用
* 容器默认没有内存限制
* [参数说明](https://blog.csdn.net/CSDN_duomaomao/article/details/78567859)
* [docker container 动态修改内存限制](https://blog.csdn.net/fuck487/article/details/86096134),docker update --memory 2048m --memory-swap -1 container_name

### image文件
1. 心得
  1. 区别基础镜像和业务镜像，前者可用于export，后者export时ENV和CMD等都会忽略
  1. 没有前台运行CMD的docker(特别是基础镜像)，后台开启时会自动关闭。可以通过"docker run -it"前台开启，然后"docker exec -it"进行具体操作

1. Dockerfile文件格式
  * [docker——Dockerfile创建镜像](http://www.cnblogs.com/niloay/p/6261784.html)
  * CMD和ENTRYPOINT区别，前者会被docker run替代，后者不会被忽略，一定会被执行

1. 脚本构建image
  * 创建文件Dockfile
  * docker build -t image:tag .
  * [Dockerfile构建镜像详情](http://blog.51cto.com/nginxs/1893058)

1. image存储
  1. save成文件
  1. 上传到公共云。[docker镜像上传到阿里云](http://www.cnblogs.com/afangxin/p/6601099.html)

### Dockerfile
```
# tomcat网站示例[已废弃]，目录下要有网站目录和server.xml

FROM tomcat
MAINTAINER andrew
LABEL version="1.0"

ENV SITE_NAME hi
ENV SITE_HOME /usr/local/tomcat/webapps/$SITE_NAME
RUN mkdir -p "$SITE_HOME"

COPY $SITE_NAME $SITE_HOME
COPY server.xml /usr/local/tomcat/conf/server.xml

EXPOSE 80
CMD ["catalina.sh", "run"]

```

### MySql数据分离
* [使用Docker快速搭建MySql，并进行数据卷分离](http://www.jianshu.com/p/57420240e877)

### [所有docker实例不自动启动](https://unix.stackexchange.com/questions/390684/how-to-disable-containers-from-auto-starting-with-dockerd-while-docker-isnt-ru)
```
find /var/lib/docker/containers/ -type f -name hostconfig.json -exec grep -o '"RestartPolicy[^}]*}'  {} + | grep -v '"never"' | cut -d: -f1 | xargs -r sed -i 's/\("RestartPolicy":{"Name":\)"[^"]*"/\1"no"/'
```

### [Docker/Docker-Compose自动创建的网桥与局域网冲突解决方案](https://www.cnblogs.com/autohome7390/p/10955118.html)
docker默认的网络模式是bridge，默认网段是172.17.0.1/16(下一个网段是第二位+1)。可能和局域网冲突。
方案是修改docker的默认开始网段。nano /etc/docker/daemon.json：
```
{
  "debug" : true,
  "default-address-pools" : [
    {
      "base" : "172.30.0.0/16",
      "size" : 24
    }
  ]
}
```

### alpine
* 进入容器：docker exec -it CONTAINER sh
* [软件包管理](https://blog.csdn.net/hxpjava1/article/details/80221307)：apk add。[支持包查询](https://pkgs.alpinelinux.org/packages)

## 命令
### 常用
1. 登录实例
```
docker exec -it myNginx /bin/bash
```
docker run/exec <相关参数> <image ID> <初始命令>
  * -i：表示以“交互模式”运行container
  * -t：表示container启动后会进入其命令行
  * -v：表示需要将本地哪个目录挂载到container中，格式：-v <宿主机目录>:<container目录>
  * -d：表示以“守护模式”执行<初始命令>
  * -p：表示宿主机与container的端口映射，-v <宿主机端口>:<container端口>
  * --name：表示container名称
  * --restart=always：服务自启动
1. 查看日志

```
https://www.jianshu.com/p/1eb1d1d3f25e
docker logs --tail 0 -f container // 实时查看最新的[不用看历史的]
docker logs -f -t --since="2017-12-31" --tail=10 container

--since : 此参数指定了输出日志开始日期，即只输出指定日期之后的日志。
-f : 查看实时日志
-t : 查看日志产生的日期
-tail=10 : 查看最后的10条日志
```
1. 关闭实例

```
docker stop myNginx && docker rm myNginx
```
1. 重启实例

```
docker restart myNginx
```
1. 关闭所有实例：docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)
1. 关闭名称匹配的实例：docker stop $(docker ps -a -q --filter="name=XYZ") && docker rm $(docker ps -a -q --filter="name=XYZ")
1. 外部运行container实例的脚本：docker exec -d myHttpd sh -c "echo 'export LC_ALL=zh_CN.UTF-8'  >>  /etc/profile"

### 全部
* dockerd // 直接启动，可以看启动log，查看问题
* docker search image // 搜索仓库的image
* docker pull image:tag // 下载仓库的image，tag不写就用最新的
* docker pull registry/redis // 下载特定仓库的image。registry如registry.docker-cn.com
* docker images // 查看本地所有image
* docker ps // 查看当前正在运行的container
* docker top // 查看运行container中运行的进程
* docker run -i -t -v /opt/:/mnt/opt/ container /bin/bash // 启动docker实例，加载目录
* docker exec -i -t container /bin/bash // 打开docker实例console
* docker exec -d container touch /tmp/new_file // 后台运行实例命令：创建文件
* docker stop container // 停止docker实例，依旧存在
* docker start container // 启动docker实例，run的简化命令
* docker rm container // 删除docker实例，类似stop
* docker rm $(docker ps -qa --filter status=exited) // 删除所有Exited的docker实例
* docker ps -a --filter status=exited --format {{.ID}} // 获取列“ID”的值
* docker rm $(docker ps -a -q) // 删除所有stop的docker实例
* docker rmi image // 删除docker image
* docker kill container // 杀死docker实例，类似stop
* docker logs container // 查看日志
* docker save -o image.tar image:tag // image保存成image文件。docker save -o r.tar redis
* docker load -i image.tar // 加载image文件，和save配套。docker load -i r.tar
* docker export container > image.tar // 容器导出成image文件，无metadata和历史
* cat image.tar | docker import - image:tag // 导入image文件，和export配套
* docker import --change 'CMD ["/usr/bin/supervisord"]' image.tar image:tag // 加参数导入
* docker commit -p container image:tag // [保存container的数据到image](https://www.runoob.com/docker/docker-commit-command.html)
* docker build -t fs/tomcat:v1 . // 当前目录生成image
* docker network create --subnet=192.168.2.0/16 // 创建docker虚拟网络，用于局域网docker通讯
* docker system
* docker system prune // 清理
* docker system prune -a // 没使用的image也会清理，慎用

## 运行示例
### nginx
```
docker stop myNginx && docker rm myNginx
docker run \
  --name myNginx \
  -d -p 80:80 \
  -e "LANG=C.UTF-8" \
  -v /docker/conf/nginx/nginx.conf:/etc/nginx/nginx.conf:ro \
  -v /docker/conf/nginx/conf.d:/etc/nginx/conf.d \
  nginx
docker cp /etc/localtime myNginx:/etc/localtime
```

### mysql
```
docker stop myMysql && docker rm myMysql
docker run \
  --name myMysql \
  -d -p 3312:3306 \
  -e "LANG=C.UTF-8" -e MYSQL_ROOT_PASSWORD=123456 \
  -v /docker/conf/mysql/mysql.cnf:/etc/mysql/mysql.cnf:ro \
  -v /docker/data/mysql:/var/lib/mysql \
  -v /docker/log/mysql:/var/log/mysql \
  mysql
docker cp /etc/localtime myMysql:/etc/localtime

// 设置远程访问，建议设置复杂的root密码
docker exec -it myMysql /bin/bash
mysql -uroot -p -P3312
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION; FLUSH PRIVILEGES; EXIT;
```


### mongo
```
docker stop myMongo && docker rm myMongo
docker run \
  --name myMongo \
  -d -p 23313:27017 \
  -e "LANG=C.UTF-8" \
  -v /docker/data/mongo:/data/db \
  mongo
docker cp /etc/localtime myMongo:/etc/localtime
```

### activemq
```
docker stop myActivemq && docker rm myActivemq
docker run \
  --name myActivemq \
  -d -p 1883:1883 -p 5672:5672 -p 3313:8161 -p 61613:61613 -p 61614:61614 -p 3314:61616 \
  -e "LANG=C.UTF-8" \
  -v /docker/conf/activemq/activemq.xml:/opt/activemq/conf/activemq.xml:ro \
  -v /docker/conf/activemq/jetty.xml:/opt/activemq/conf/jetty.xml:ro \
  -v /docker/conf/activemq/jetty-realm.properties:/opt/activemq/conf/jetty-realm.properties:ro \
  -v /docker/data/activemq:/opt/activemq/data \
  webcenter/activemq
docker cp /etc/localtime myActivemq:/etc/localtime
```

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

## 资料
1. [Docker Compose 方式下的容器网络基础知识点](https://michael728.github.io/2019/06/15/docker-compose-networks)，https://docs.docker.com/compose/networking/
```
不设置name，name会是"目录_abc"
networks:
  abc:
    name: abc
```
1. docker启动后不关闭的命令(docker无命令会自动关闭)：tail -f /dev/null
1. [语法](https://www.cnblogs.com/freefei/p/5311294.html)
1. [控制docker-compose中服务的启动顺序](https://blog.csdn.net/xiao_jun_0820/article/details/78676765)
```
depends_on:
  - "db"
command: ["./wait-for-it.sh", "db:3306", "--", "python", "app.py"]
```
