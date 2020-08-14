# Nexus(maven仓库私服)

## 资料
* [安装](http://blog.163.com/sz2273_pr/blog/static/4126429620135811573231/)
  * wget https://sonatype-download.global.ssl.fastly.net/nexus/oss/nexus-2.14.5-02-bundle.tar.gz
* 管理默认网址：[http://localhost:8081/nexus](http://localhost:8081/nexus)
* [上传方法](http://m635674608.iteye.com/blog/2262390)
* [账号管理](http://blog.csdn.net/woshixuye/article/details/8135054)
* [内存调整](https://support.sonatype.com/hc/en-us/articles/213465178-Adjusting-memory-allocated-to-Nexus)

## 命令
* 启动
```
export RUN_AS_USER=root
sh /{nexus}/bin/nexus start
```
* [迁移](http://blog.csdn.net/kinglyjn/article/details/53585721)
```
scp -r root@{IP}:{sonatype-work}nexus/indexer/* {sonatype-work}nexus/indexer/
scp -r root@{IP}:{sonatype-work}nexus/storage/* {sonatype-work}nexus/storage/
```
