# Maven
## 使用
1. m2安装目录：/Users/root/.m2/，/root/.m2/
1. 配置使用第三方仓库
```
<repositories>
      <repository>
          <id>mvnrepository</id>
          <name>mvnrepository</name>
          <url>https://mvnrepository.com</url>
          <releases>
              <enabled>true</enabled>
          </releases>
      </repository>
</repositories>
```
1. 发布到仓库：[maven-release-plugin](https://blog.csdn.net/crowhyc/article/details/76204315)

## 命令
* mvn clean install -Dmaven.test.skip=true
* mvn clean package

## 安装
1. CentOS7
```
wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
yum -y install apache-maven
```
