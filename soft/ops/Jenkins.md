# Jenkins
## 命令
  * service jenkins restart

## 语法

## 使用
* 工作目录参数：%workspace%

## 资料
* [Ubuntu安装](http://blog.csdn.net/fenglailea/article/details/25919367)
* [关闭部分日志功能](http://blog.csdn.net/qq_33588470/article/details/54647496)，javax.jmdns
* [jenkins credentials & git ssh 认证](http://blog.csdn.net/gw569453350game/article/details/51911179)
* [Process leaked file descriptors error on JENKINS](http://stackoverflow.com/questions/17024441/process-leaked-file-descriptors-error-on-jenkins)：-Dhudson.util.ProcessTree.disable=true
* [解决无法切换到jenkins用户的问题](http://blog.csdn.net/csfreebird/article/details/27968019)
* [jenkins 入门教程(上)](http://www.cnblogs.com/yjmyzz/p/jenkins-tutorial-part-1.html)
* [jenkins用户权限配置](https://www.jianshu.com/p/fca6c3ecde5d)
* Jenkins workflow job: Use parameter as branch specifier
  * 解决方法：disable "Lightweight checkout" checkbox

### 流水线
* 采用groovy
* [官方资料](https://www.jenkins.io/zh/doc/book/pipeline/)
* [常用环境变量](https://blog.csdn.net/qq_41030861/article/details/105171222)
* [片段生成器](http://%domain%/job/%jobName%/pipeline-syntax/)
* [官方共享库](https://www.jenkins.io/zh/doc/book/pipeline/shared-libraries/), [共享库](https://www.qikqiak.com/post/jenkins-shared-library-demo/)
```
1 共享库开发
新建共享库的git
写个静态类，如/vars/util.groovy
可以在里面使用linux的shell
sh """
  ls
"""
2 共享库设置到Jenkins
菜单 : 系统管理-系统设置-Global Pipeline Libraries。设置如下：
Library Name : 可以自定义，当前示例用了common
Default version : 共享库的git分支号
3 共享库使用(业务pipeline文件)
@Library('common')_
script {
  util.静态函数(参数)
}
```
