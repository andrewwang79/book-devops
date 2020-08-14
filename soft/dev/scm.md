# Git
## 资料
1. [centos7编译安装](http://blog.csdn.net/chrislyl/article/details/70876682)，[参考2](http://blog.csdn.net/zongyinhu/article/details/54695404)
  * 脚本

```
# 依赖库
yum -y install autoconf

yum install curl-devel expat-devel gettext-devel openssl-devel zlib-devel  -y #以下四行是：安装git的依赖包
yum install curl libcurl4-openssl-dev perl cpio expat asciidoc docbook2x -y
yum install cpan -y
yum install perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker -y

# 下载
wget https://www.kernel.org/pub/software/scm/git/git-2.9.3.tar.gz
tar zxvf git-2.9.3.tar.gz
cd git-2.9.3

# 安装
autoconf
./configure
make
make install
```
