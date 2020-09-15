# 最佳实践
## 标准
目录是"dockerfiletest_0.1"

### 在dockerA里执行dockerB
```
# 1. 宿主机上启动dockerA
docker stop dockerA && docker rm dockerA
docker run -d --cap-add=ALL --name dockerA -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker -v /usr/lib/x86_64-linux-gnu/libltdl.so.7:/usr/lib/x86_64-linux-gnu/libltdl.so.7 ImageA:0.1

# 2. dockerA里执行dockerB(dockerfiletest:0.1)
# 等同于在宿主机上执行dockerB，所以此处的/home就是宿主机的/home
# ttttt是写到的文件名。b.out返回值是1，a.out返回值是0
docker run -v /home:/data dockerfiletest:0.1 ttttt b.out
```

## 配置文件可基于环境变量动态化
docker-entrypoint.sh
```
#!/bin/bash
if [[ $redis_ip ]]; then
	sed -i 's/redis_ip="[0-9.]*"/redis_ip="'$redis_ip'"/' config.ini
fi
```

执行时的环境变量：docker run -d -e redis_ip=192.168.100.100 xxx

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
