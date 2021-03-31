# Dockerfile
1. Dockerfile文件格式
  * [docker——Dockerfile创建镜像](http://www.cnblogs.com/niloay/p/6261784.html)
  * CMD和ENTRYPOINT区别，前者会被docker run替代，后者不会被忽略，一定会被执行：https://www.cnblogs.com/sparkdev/p/8461576.html

1. 脚本构建image
  * 创建文件Dockfile
  * docker build -t image:tag .
  * [Dockerfile构建镜像详情](http://blog.51cto.com/nginxs/1893058)

### Dockerfile
```
ENV MYSQL_MAJOR 5.7
ENV SITE_HOME /usr/local/mysql/$MYSQL_MAJOR
RUN mkdir -p "$SITE_HOME"

# 拷贝文件
COPY file/docker-entrypoint.sh /usr/local/bin/
# 拷贝目录，新建目录，将*拷贝过去
RUN mkdir -p "abc"
COPY file/bb/. abc/  .是所有，*是文件

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
```
