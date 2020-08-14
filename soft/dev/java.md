# Java

## 时区
* [docker容器 java 默认读取系统时区问题](https://blog.csdn.net/SoberChina/article/details/84849860)
* 顺序：TZ变量, /etc/timezone, /etc/localtime文件与"/usr/share/zoneinfo目录下所有时区文件一致的是该时区，标准GMT
* java的VM和DB需是同一个时区
