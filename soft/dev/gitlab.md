# 安装
```
centos：
https://www.jianshu.com/p/2439ba164440

ubuntu16：
https://github.com/git-lfs/git-lfs/releases，页面下载AMD64版本
tar -xzvf git-lfs-linux-arm64-v2.8.0.tar.gz
./install.sh

dockerfile安装：
WORKDIR $INSTALL_PATH
RUN mkdir $INSTALL_PATH/gitlfs  && tar -xvzf /data/devops/git-lfs-linux-amd64-v2.13.2.tar.gz
WORKDIR $INSTALL_PATH/gitlfs
RUN ./install.sh
```

# docker里路径
* tail -f /var/log/gitlab/nginx/gitlab_error.log
* /var/opt/gitlab/nginx/conf/gitlab-http.conf
* /opt/gitlab/embedded/sbin/nginx -p /var/opt/gitlab/nginx -s reload

# lfs troubleshooting
1. 服务端内存不够：调整最大内存
1. 超时：修改nginx和超时时间和buffer
1. pull时客户端内存不够：增加内存，如虚拟内存
1. 1G文件无法上传：注意文件后缀，比如git lfs track "*.part0" && git lfs track "*.part1" && git lfs track "*.part2" && git lfs track "*.part3" && git lfs track "*.part4" && git lfs track "*.part5" && git lfs track "*.part6"

# 资料
* [gitlab-workhorse](https://juejin.cn/post/6844903860016775175)

## 配置
```
git：https://manpages.debian.org/testing/git-lfs/git-lfs-config.5.en.html
[http]
        postBuffer = 10485760000
[lfs]
        tlstimeout = 3600
        dialtimeout = 3600
        activitytimeout = 3600
        keepalive = 3600
        concurrenttransfers = 1
nginx：
        keepalive_timeout  6000s;
        client_max_body_size 20000m;

        proxy_read_timeout  86400s;
        proxy_connect_timeout   3600s;
        proxy_request_buffering off;

git config --global http.postBuffer 2048M
git config --global http.maxRequestBuffer 1024M
git config --global core.compression 9

git config --global ssh.postBuffer 2048M
git config --global ssh.maxRequestBuffer 1024M

git config --global pack.windowMemory 256m
git config --global pack.packSizeLimit 256m
```

## 其他
* [GitLab 之 Git LFS 大文件存储的配置](https://blog.csdn.net/aixiaoyang168/article/details/76012094)
