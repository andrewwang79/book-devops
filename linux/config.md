# 服务器配置
## 进程和文件数量不限制
```
nano /etc/security/limits.conf, 注意nofile不能写unlimited

root hard nofile 65536
root soft nofile 65536
root hard nproc unlimited
root soft nproc unlimited

* hard nofile 65536
* soft nofile 65536
* hard nproc unlimited
* soft nproc unlimited

检查方法: ulimit -a
重新登录即可生效
已开启的服务需重启才可生效【简单的方法是直接重启服务】
```

## 增加交换内存(如对内存总量有需求)
```
创建4G的交换内存(/var/swapfile)

dd if=/dev/zero of=/var/swapfile bs=1024 count=4194304 && chmod 0600 /var/swapfile   //创建交换空间，count当前单位是K，因为bs是1024byte
mkswap /var/swapfile
swapon /var/swapfile // 启用
echo '/var/swapfile swap swap default 0 0' >> /etc/fstab // 永久生效

检查方法：swapon --show

swapoff /var/swapfile && rm -rf /var/swapfile // 停用并删除
删除/etc/fstab上新增的行
```
## 硬盘自动挂载
https://blog.csdn.net/qq_39341113/article/details/103542825
```
查看挂载：df -h
查看分区：fdisk -l
格式化&挂载：mkfs -t ext4 /dev/sdb && mount -t ext4 /dev/sdb /opt
永久挂载：echo "/dev/vdb /data ext4 defaults 0 2" >> /etc/fstab
```
## 固定IP
https://forum.ubuntu.org.cn/viewtopic.php?f=73&t=190174

## 启用SSH

## 时间设置成UTC+8
```
查看时区：date -R
调整时区：dpkg-reconfigure tzdata，并选择Asia，Shanghai
调整时间：date -s '2019-01-01 00:00:00'。同步BIOS时间：hwclock -w
```
## 系统日志
* 禁用rsyslog[不建议使用]
```
systemctl stop rsyslog
systemctl disable rsyslog
logrotate -d /etc/logrotate.d/rsyslog
```
* 关闭部分日志 [Linux的/var/log/messages文件占用太大问题](https://www.jianshu.com/p/97fe34062a74)

## 开放22和80端口

## 安装依赖软件
### docker，配置docker的log，设置成默认启动
nano /etc/docker/daemon.json，修改好后重启docker(service docker restart)

```
{
  # 启用GPU模块
  "runtimes": {
    "nvidia": {
      "path": "nvidia-container-runtime",
      "runtimeArgs": []
    }
  }

  "log-driver":"json-file",
  "log-opts": {"max-size":"500m", "max-file":"3"},

  # 可选，数据路径调整
  "data-root": "/data/docker",
  "storage-driver": "overlay"
}
```

### docker-compose

## 其他常用操作
* ulimit -a // 查看用户的限制，包括最大文件数量
* lsof|awk '{print $2}'| wc -l // 文件数量
* [温度监控](https://www.linuxprobe.com/ubuntu-cpu-temperature.html)
* [通过Linux 日志查看系统异常原因](https://blog.51cto.com/svsky/1672587)
* 硬盘扩容：mount /dev/vdc /data && resize2fs /dev/vdc
* [系统自启动配置](https://andrewwang79.gitbooks.io/ops/linux/common.html#%E7%B3%BB%E7%BB%9F%E8%87%AA%E5%90%AF%E5%8A%A8%E9%85%8D%E7%BD%AE)
