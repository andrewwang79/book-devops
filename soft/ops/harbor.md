# harbor

1. 下载离线安装包: wget https://storage.googleapis.com/harbor-releases/release-1.8.0/harbor-offline-installer-v1.8.1.tgz
1. 解压: tar xvf harbor-offline-installer-v1.8.1.tgz
1. 按需修改 harbor.yml
1. 执行sh prepare, 会生成一个docker-compose文件，对这个文件进行按需修改
1. 执行docker-compose up -d 即可启动harbor
