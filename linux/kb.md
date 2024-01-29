# 知识
* [Linux命令大全](https://man.linuxde.net/)

## CentOS
1. [Centos7 系统优化](https://www.jianshu.com/p/0a06b306449a)
1. 安装chrome浏览器：rpm -i https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

## Ubuntu
1. [安装桌面版](https://ubuntu.com/tutorials/install-ubuntu-desktop)
1. [Shell重定向](https://blog.csdn.net/u011630575/article/details/52151995)

## 脚本及启动机制
1. 脚本
  1. /etc/profile // 系统+登录
  1. $HOME/.profile // 用户+登录
  1. $HOME/.bashrc // 用户+非登录
1. 启动机制
  1. 先跑系统的，再跑用户的
  1. 先跑bashrc，再跑profile(登录状态)

## 系统日志
* (journal日志](https://www.cnblogs.com/jiuchongxiao/p/9222953.html)

## 软件安装
### ffmpeg
1. ffmpeg -version
1. centos：https://www.jianshu.com/p/11a3e9c91c38
1. debian：apt update && apt-get install -y ffmpeg

### chrome
1. google-chrome --version
1. centos：yum install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
1. Ubuntu：wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && dpkg -i google-chrome-stable_current_amd64.deb && rm -f google-chrome-stable_current_amd64.deb

## 局域网时间同步配置(chrony)
* 动态同步，几分钟到几小时。Windows客户端可以支持
* 以下命令在server和client都需运行
```
apt install chrony
systemctl stop systemd-timesyncd
systemctl disable systemd-timesyncd
```

### server操作
```
nano /etc/chrony/chrony.conf
  allow 192.168.1.0/24
  allow all
systemctl restart chrony
```

## client
```
nano /etc/chrony/chrony.conf
  去掉pool
  server 192.168.1.135 iburst minpoll 6 maxpoll 10
systemctl restart chrony
```

### 命令和同步执行确认
1. 确认client正常工作
```
chronyc sources：确认状态不是“^?” // 确认已连到server
chronyc tracking：确认“Ref time (UTC)”是现在 // 确认已执行过同步
```

1. 手动发起同步
```
chronyc -a 'burst 4/4' // 进行四次测量，并在每次测量之间等待间隔时间
chronyc -a makestep // 立即调整系统时间，无论差异有多大
```
