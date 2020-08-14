# Tomcat

## 操作
* 脚本：/usr/local/tomcat/bin/startup.sh，/usr/local/tomcat/bin/shutdown.sh
* [重启操作](http://www.cnblogs.com/it563/articles/1956334.html)
* 新增虚拟目录
```
server.xml的host路径下新增：<Context docBase="网站所在目录" path="/相对网址" reloadable="true" source="org.eclipse.jst.jee.server:网站所在目录" />
<Context docBase="hi" path="/hi" reloadable="true" source="org.eclipse.jst.jee.server:hi"/>
```

## 资料
1. 日志类型
  1. catalina日志：catalina.out是标准输出和标准出错，所有输出到这两个位置的都会进入catalina.out，包含tomcat运行自己输出的日志以及应用里向console输出的日志。catalina.{yyyy-MM-dd}.log是tomcat自己运行的一些日志，这些日志还会输出到catalina.out
  1. localhost日志：应用向console输出的日志。localhost.{yyyy-MM-dd}.log主要是应用初始化(listener, filter, servlet)未处理的异常最后被tomcat捕获而输出的日志，而这些未处理异常最终会导致应用无法启动。
1. [Tomcat]性能监控](https://www.cnblogs.com/yjd_hycf_space/p/7755633.html)

## Ubuntu
* [安装](https://www.djamware.com/post/588df76680aca722878a364a/install-nginx-tomcat-7-and-java-8-on-ubuntu-1604)
* 日志：/var/log/tomcat7
* 网站：/var/lib/tomcat7/webapps/

## mac
* [Mac下安装Tomcat](https://www.jianshu.com/p/db08d23049ce)
* 启动：sh {path}/tomcat/startup.sh
