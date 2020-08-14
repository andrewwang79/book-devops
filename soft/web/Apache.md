# Apache

1. 命令
    * 增加网站
      * Ubuntu：在目录/etc/apache2/sites-available/增加配置文件，如conFile。
      * centos：直接在配置文件底部追加
    * 启用网站：a2ensite confFile
    * 禁用网站：a2dissite confFile
    * 重新加载：service apache2 reload
    * 重新加载：service httpd reload
    * 版本：http -v

1. 权限配置
```
    # backwards compatibility with apache 2.2
    Order allow,deny
    Allow from all

    # forward compatibility with apache 2.4
    Require all granted
    Satisfy Any
```
1. 配置检查
apachectl configtest
