# Dockerfile
1. Dockerfile文件格式
  * [docker——Dockerfile创建镜像](http://www.cnblogs.com/niloay/p/6261784.html)
  * CMD和ENTRYPOINT区别，前者会被docker run替代，后者不会被忽略，一定会被执行：https://www.cnblogs.com/sparkdev/p/8461576.html
  * 来自CMD和ENTRYPOINT的容器启动脚本里操作的临时环境变量只能生效在首个terminal，ssh出来的新terminal不会生效。需要其他terminal里也生效的，需放到terminal启动文件里。

1. 脚本构建image
  * 创建文件Dockfile
  * docker build -t image:tag .
  * [Dockerfile构建镜像详情](http://blog.51cto.com/nginxs/1893058)

### Dockerfile
```
# 通用环境参数
ENV LANG C.UTF-8
ENV MYSQL_MAJOR 5.7
ENV SITE_HOME /usr/local/mysql/$MYSQL_MAJOR
RUN mkdir -p "$SITE_HOME"

# 调整sh为bash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# root可远程登录
COPY $FILE_PATH/sshd_config /etc/ssh/sshd_config
# 设置root密码
RUN echo "root:12345678" | chpasswd

# 修改apt源
COPY ./file/sources.list /etc/apt/sources.list
RUN apt-get clean && apt-get -yq update

# 安装 git-lfs，不行就用https://www.cnblogs.com/allmignt/p/12353756.html
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash
RUN apt-get -yq install git-lfs

# 拷贝文件
COPY file/docker-entrypoint.sh /usr/local/bin/
# 拷贝目录，新建目录，将*拷贝过去
RUN mkdir -p "abc"
COPY file/bb/. abc/  .是所有，*是文件

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
```
