# 常用

## 命令
* ipconfig /release // 客户机释放DHCP租约
* ipconfig /renew // 客户机重新申请DHCP租约
* ipconfig /flushdns // 重置DNS
* sc config wuauserv start= disabled // 禁用自动更新服务，下次重启电脑生效
* 端口查进程：netstat -ano | findstr :10401
* kill进程：TSKILL 11111
* tasklist | findstr 4872
* cls // 清空Cmd的屏幕，clear screen

### 日期时间设置
* Windows10改系统时间：“开始”菜单>“设置”>“时间和语言”>“日期和时间”>关闭“自动设置时间”>“手动设置日期和时间”
* 命令改系统时间：新建bat文件写入以下内容，执行【cmd里无法执行】
```
date 2021 11 26
time 11:43:09
```
* 改文件时间：软件ctime

### 增加DNS映射
```
notepad C:\Windows\System32\drivers\etc\hosts
编辑：IP domain
cmd：ipconfig /flushdns
```

### 资源管理器和cmd互开
* 资源管理器 -> cmd : 路径里输入cmd
* cmd ->  资源管理器: start .

### Win10里SSH免密登录Linux
* IP方式：https://zhuanlan.zhihu.com/p/80364375
* 域名/IP方式：https://segmentfault.com/a/1190000038657243, IdentityFile是私钥文件

### 修改cmd窗口的语言代码
```
chcp // 查看当前cmd的代码页编号
chcp 65001 // 修改当前cmd的代码页到UTF-8
```
