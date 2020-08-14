# Windows

## 命令
* ipconfig /release // 客户机释放DHCP租约
* ipconfig /renew // 客户机重新申请DHCP租约
* ipconfig /flushdns // 重置DNS
* sc config wuauserv start= disabled // 禁用自动更新服务，下次重启电脑生效

### 增加DNS映射
```
notepad C:\Windows\System32\drivers\etc\hosts
编辑：IP domain
cmd：ipconfig /flushdns
```

## 资料
* [Windows: Ignore errors with Xcopy and RoboCopy](https://djlab.com/2010/12/windows-ignore-errors-with-xcopy-and-robocopy/)
