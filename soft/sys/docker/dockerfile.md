# Dockerfile
> [docker——Dockerfile创建镜像](http://www.cnblogs.com/niloay/p/6261784.html)

## 使用
### [CMD和ENTRYPOINT](https://www.cnblogs.com/sparkdev/p/8461576.html)
1. 1个镜像只有最后1个ENTRYPOINT和CMD指令生效。子镜像会覆盖父镜像的
1. docker run里的命令：会替代CMD；不会替代ENTRYPOINT，一定会执行
    1. ENTRYPOINT定义容器的主要命令或可执行文件，通过docker run把镜像当成命令使用
    1. CMD指定容器启动时命令
1. CMD和ENTRYPOINT脚本里赋值的环境变量只能生效在首个terminal，(ssh出来的)新terminal不会生效。如需要需放到terminal启动的执行文件(如~/.bashrc)。所以：
    1. 一次性的命令放到CMD和ENTRYPOINT脚本(如启动ssh)
    1. 环境变量类的放到终端启动的执行文件

### 构建时的输出
* 输出到标准输出会构建时可见：如RUN ls不可见，RUN ls -al可见

## 镜像构建流程
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
COPY file/. abc/  .是file目录结构不变的复制，*是file目录下所有文件放到根目录的复制

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
```
