# Windows

## 命令
* ipconfig /release // 客户机释放DHCP租约
* ipconfig /renew // 客户机重新申请DHCP租约
* ipconfig /flushdns // 重置DNS
* sc config wuauserv start= disabled // 禁用自动更新服务，下次重启电脑生效
* 端口查进程：netstat -ano | findstr :10401
* kill进程：TSKILL 11111
* tasklist | findstr 4872

## 批处理
```
md a\b // 创建多层目录
rd /s/q build // 删除目录
rd /s/q build & md build & cd build cmd // 一行命令执行多条指令 https://blog.csdn.net/yrk0556/article/details/104308866

set BOOLVAL=true # 其他值都是false
IF "%BOOLVAL%"=="true" (
  echo "yes"
) ELSE (
  echo "no"
)
```

### 日期时间设置
```
date 2021 11 18
time 12:23:09
```

### 增加DNS映射
```
notepad C:\Windows\System32\drivers\etc\hosts
编辑：IP domain
cmd：ipconfig /flushdns
```

## 资料
* [windows CMD命令大全及详细解释和语法](http://xstarcd.github.io/wiki/windows/windows_cmd_syntax.html)
* 时间: %date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
* [Windows: Ignore errors with Xcopy and RoboCopy](https://djlab.com/2010/12/windows-ignore-errors-with-xcopy-and-robocopy/)
* Win10 SSH 免密登录 linux : https://zhuanlan.zhihu.com/p/80364375, https://blog.csdn.net/lisongjia123/article/details/78513244
