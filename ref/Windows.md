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
* [Windows批处理脚本指南: for循环](https://www.jb51.net/article/93170.htm)
* [Windows批处理脚本指南: 变量](https://www.jianshu.com/p/5e364800955e)
* [处理参数的引号](https://blog.csdn.net/cocokim_122/article/details/41896351): 最外层不加引号，不影响数据。如set p1="aaa" bb。%p1%会如实体现【"aaa" bb】

```
// 操作
md a\b // 创建多层目录
rd /s/q build // 删除目录
rd /s/q build & md build & cd build // 一行命令执行多条指令 https://blog.csdn.net/yrk0556/article/details/104308866

// 变量，特别是中间有空格的
SET "PATH=%PATH%;C:\Program Files (x86)\path with special characters"

// 判断
set BOOLVAL=true # 其他值都是false
IF "%BOOLVAL%"=="true" (
  echo "yes"
) ELSE (
  echo "no"
)

// 遍历获取第一层目录并git pull
set work_path=D:\book\wangyaqi\
for /f %%i in ('dir /b /ad %work_path%') do (
  echo pull %work_path%%%i
  git -C %work_path%%%i pull
)
```

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

## 资料
* [windows CMD命令大全及详细解释和语法](http://xstarcd.github.io/wiki/windows/windows_cmd_syntax.html)
* 时间: %date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
* [Windows: Ignore errors with Xcopy and RoboCopy](https://djlab.com/2010/12/windows-ignore-errors-with-xcopy-and-robocopy/)
* Win10 SSH 免密登录 linux
 * IP方式：https://zhuanlan.zhihu.com/p/80364375
 * 域名/IP方式：https://segmentfault.com/a/1190000038657243, IdentityFile是私钥文件
