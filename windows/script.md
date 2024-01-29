# 脚本
* [Windows批处理脚本指南: for循环](https://www.jb51.net/article/93170.htm)
* [Windows批处理脚本指南: 变量](https://www.jianshu.com/p/5e364800955e)
* [参数的引号](https://blog.csdn.net/cocokim_122/article/details/41896351)
  * 引号是字符串，加了就会体现，加N次就会有N层引号。
    * set p1="aaa" bb && echo %p1%  ->  "aaa" bb
    * set p2="%p1%" && echo %p2%  ->  ""aaa" bb"
  * 最佳实践：在字符串首次定义的地方有需要就加引号，过程中不要加引号
  * 去掉字符串的首尾引号(字符) : set var=%var:~1,-1%

## 输入参数
1. 输入参数使用：%N。%1第一个参数
1. 参数数量：$#
1. 参数所有的值：$*
1. 有等号的字符串输入参数(如COLOR=RED)必须加双引号，否则会被分成2个参数(COLOR, RED)
```
echo param is [%*]
set _argC=0
for %%x in (%*) do Set /A _argC+=1
if %_argC% NEQ 3 (
    echo error : param count should be 3[%_argC%]
    goto:eof
)
```

## 环境变量
1. set // 查看当前所有环境变量
1. echo %path% // 查看单个环境变量
1. set path=d:\test // 修改单个环境变量
1. set path=%path%;d:\test // 追加单个环境变量

## 常用脚本
```
// 操作
md a\b // 创建多层目录，注意是左斜线
rd /s/q build // 删除目录，包括里面的所有文件子目录
del file // 删除文件
rd /s/q build && md build && cd build // 一行命令执行多条指令 https://blog.csdn.net/yrk0556/article/details/104308866
xcopy /s /y a\\config\\ b\\config\\ // 拷贝目录"a/config"下的文件到目录"b/config"
[move](https://blog.csdn.net/zhangchao5821/article/details/78641351)，太简单，没有多少用途。且不带*的mv在脚本文件里无效。

// 变量，特别是中间有空格的
SET "PATH=%PATH%;C:\Program Files (x86)\path with special characters"

// 输入参数空判断
set one=%1
if "%one%"=="" (
echo 无) else (
echo 有)
if "%one%" NEQ "" (
echo 有) else (
echo 无)

// 判断
set BOOLVAL=true # 其他值都是false
if "%BOOLVAL%"=="true" (
  echo "yes"
) else (
  echo "no"
)
set TEXTVAL="123"
if "%TEXTVAL%"=="123" (
  echo "yes"
) else if "%TEXTVAL%"=="1" (
  echo "maybe"
) else (
  echo "no"
)

// 文件存在判断
if exist %filePath% (
  echo "exist"
) else (
  echo "not exist"
)

// 遍历获取第一层目录并git pull
set work_path=D:\book\wangyaqi\
for /f %%i in ('dir /b /ad %work_path%') do (
  echo pull %work_path%%%i
  git -C %work_path%%%i pull
)

// 调用脚本
call "%script_dir%\function.bat" :fnX "C:\path\to\cicd" // 调用指定路径的脚本文件的函数fnX，参数1是字符串
在call脚本CS和上级脚本PS，变量是通用的。就是说CS和PS都有var1，在CS改了var1值，PS里的var1值也会改

// 退出
EXIT // 退出所有脚本，Cmd窗口会关闭
EXIT /B // 退出所有脚本，Cmd窗口不会关闭
GOTO : EOF // 只是退出当前脚本文件，调试比较好用
if %errorlevel% neq 0 echo "error : ..." && exit /B // 上个命令失败(错误值不等于0)，终止当前脚本执行，返回到调用脚本的位置
call build.bat || (echo "error : build.bat" & exit /B) // 执行命令，失败退出

// 调试常用
PAUSE // 暂停

// 注释
:: 我是注释 // 按行注释，不显示
REM 我是注释 // sh不执行后面的语句，但是会显示

// 当前工作目录的路径，不是脚本文件所在路径
set currentDir = %cd%"

// 当前执行的脚本文件的所在路径
set script_file_path="%~dp0%"
```

## 多命令执行
* cmd1 & cmd2 & cmd3 // 前一个命令运行成功失败都会继续运行下一个命令
* cmd1 && cmd2 && cmd3 // 在前一个命令运行成功（%ERRORLEVEL%==0）后会继续运行下一个命令
* cmd1 || cmd2 || cmd3 // 在前一个命令运行失败（%ERRORLEVEL% NEQ 0）后会继续运行下一个命令

## 资料
* [windows CMD命令大全及详细解释和语法](http://xstarcd.github.io/wiki/windows/windows_cmd_syntax.html)
* 时间: %date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
* [Windows: Ignore errors with Xcopy and RoboCopy](https://djlab.com/2010/12/windows-ignore-errors-with-xcopy-and-robocopy/)
* 打开系统的“启动”目录： Win+R，键入“shell:startup”
