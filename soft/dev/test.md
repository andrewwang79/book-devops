# 测试

## jmeter
### 使用流程
1. 在Windows上将计划保存成jmx文件，如a1.jmx
1. 下载jmeter解压到linux的指定目录
  1. wget https://mirrors.tuna.tsinghua.edu.cn/apache//jmeter/binaries/apache-jmeter-5.2.1.tgz && tar -zxvf apache-jmeter-5.2.1.tgz && rm apache-jmeter-5.2.1.tgz
  1. mkdir -p /usr/local/jmeter/apache-jmeter-5.2.1 && mv apache-jmeter-5.2.1 /usr/local/jmeter/
1. /usr/local/jmeter/apache-jmeter-5.2.1/bin/jmeter.sh -n -t a1.jmx

### 资料
1. [jmeter集群](https://my.oschina.net/u/1241970/blog/635507)
