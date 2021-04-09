# Nginx

## 命令
* 增加网站：在配置目录增加配置文件，如confFile。
* 检查nginx配置的语法：nginx -t
* 重新加载：nginx -s reload
* 重启：/etc/init.d/nginx restart
* 查看nginx进程：ps aux | grep "nginx: ",  查看进程owner：ps aux | grep "nginx: " | awk '{print $1}'

## 资料
* [Nginx的四大模块——proxy、headers、upstream、stream模块](https://www.cnblogs.com/kevingrace/p/8290452.html)
* [nginx 之 proxy_pass详解](https://www.jianshu.com/p/b010c9302cd0)
* [nginx常量](https://www.yuque.com/hello-qtl5f/oa6pqr/lgfh4n)

## 配置
* [未绑定域名禁止访问](https://shockerli.net/post/nginx-forbidden-unbound-domain-access/)

### 负载均衡
* [nginx的upstream目前支持的5种方式](https://www.oschina.net/question/12_24613)
* [nginx使用用户真实IP做hash（解决经过CND后ip_hash失效问题）](https://blog.51cto.com/983836259/1864239)
* [第三方模块(nginx-sticky-module)](https://blog.csdn.net/zhuyu19911016520/article/details/91351773) : 基于Cookie固定访问一个服务器

### 缓存配置
html不缓存，其他都缓存。nginx.conf的server调整，放在“location /”后面：
```
    location ~ .*\.(htm|html)?$ {
        add_header Cache-Control "private, no-store, no-cache, must-revalidate, proxy-revalidate";
    }
```

### 文件上传大小配置
[操作参考](http://blog.csdn.net/zhangxl0113/article/details/52780778)
```
nginx.conf调整：
http内：client_max_body_size 100m;
```

### 添加ssl支持
[操作参考](http://nginx.org/en/docs/http/configuring_https_servers.html)

### nginx超时时间
https://zhuanlan.zhihu.com/p/86972758

### 支持http2
```
配置文件的server段落加http2：listen 443 ssl http2;
重启：nginx -s reload
```

### 压缩配置
[操作参考](http://www.cnblogs.com/qiangweikang/p/gzip_on.html)

nginx.conf调整
```
     gzip  on;
     # gzip_min_length 1k;
     gzip_types text/plain text/css text/javascript image/jpeg image/gif image/png application/javascript application/json application/xml application/x-httpd-php;
     # gzip_vary off;
     gzip_disable "msie6";
```

测试是否生效：curl -I -H "Accept-Encoding: gzip, deflate" "http://www.xyz.com/css/main.min.css"

### 启用日志
nginx.conf调整
```
        log_format main '$remote_addr - $remote_user [$time_local] "$request" '
        '$status $body_bytes_sent "$http_referer" '
        '"$http_user_agent" "$http_x_forwarded_for"'
        '$connection $upstream_addr '
        'upstream_response_time $upstream_response_time request_time $request_time ';
        access_log /var/log/nginx/access.log main;
```
[通过Nginx,Tomcat访问日志(access log)记录请求耗时](http://www.cnblogs.com/huligong1234/p/4220017.html)

### 跨域
1. 全局：在nginx.conf中的http加
1. 每个server：因有些tomcat服务会配好跨域，建议分别设置到每个server/location
1. 内容
```
  add_header Access-Control-Allow-Origin *;
  add_header Access-Control-Allow-Headers X-Requested-With;
  add_header Access-Control-Allow-Methods GET,POST,OPTIONS;
```

### websocket支持
1. 每个server
```
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection "upgrade";
# proxy_read_timeout 86400s;
# proxy_connect_timeout 60s;
# proxy_send_timeout 60s;
```
1. 取消65535限制: stream

### 性能提升
* [nginx优化25条 - Dig All Possible](http://www.z-dig.com/nginx-optimization-25.html)
* [How to Configure nginx for Optimized Performance](https://www.linode.com/docs/web-servers/nginx/configure-nginx-for-optimized-performance)

### 防攻击
* [Nginx简单防御CC攻击的两种方法](http://zhangguangzhi.top/2017/10/26/Nginx%E7%AE%80%E5%8D%95%E9%98%B2%E5%BE%A1CC%E6%94%BB%E5%87%BB%E7%9A%84%E4%B8%A4%E7%A7%8D%E6%96%B9%E6%B3%95/)
* 网站配置目录
  * Ubuntu：/etc/nginx/sites-enabled/，以后也是用centos目录
  * centos：/etc/nginx/conf.d/

## 配置模板
### server
conf.d/目录下新增一个文件，文件内容如下：
#### 单个完整网站
```
server {
    listen 80;
    server_name www.xyz.com; // 可选，可以只用IP
    root /www/;
    index index.html index.htm login.html;
    access_log off; # 如启用日志则屏蔽本行

    location ~ .*\.(htm|html)?$ { # 不缓存html，正则规则
        add_header Cache-Control "private, no-store, no-cache, must-revalidate, proxy-revalidate";
    }
    location ~ .*.(js|css|png|jpg)$ { # 缓存静态文件，正则规则
        expires max;
    }

    location ^~ /subdirx/ { # 虚拟子目录，前缀规则，否则会匹配正则规则(一个请求只能匹配一个规则)
        alias /product/servicex/site/;
        index index.html index.htm login.html;
        location ~ .*\.(htm|html)?$ { # 不缓存html，正则规则
            add_header Cache-Control "private, no-store, no-cache, must-revalidate, proxy-revalidate";
        }
        location ~ .*.(js|css|png|jpg)$ { # 缓存静态文件，正则规则
            expires max;
        }
    }

    location ^~ /servicex/ { # 子目录反向代理到服务，前缀规则
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://servicex_host/; # 后面的斜杠不能少，作用是不传递子目录
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        # proxy_connect_timeout 60s;
        proxy_read_timeout 86400s;
        # proxy_send_timeout 60s;
    }
}
```

#### 独立服务
```
server {
    listen 80;
    server_name api.xyz.com; # 可选，可以只用IP
    access_log off; # 如启用日志则屏蔽本行

    location / { # 重定向子目录到服务
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://localhost:9020/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        # proxy_connect_timeout 60s;
        proxy_read_timeout 86400s;
        # proxy_send_timeout 60s;
    }
}
```

#### 说明
* 虚拟子目录的路径不同于root，则需自行添加缓存
* [nginx的location详解](http://outofmemory.cn/code-snippet/742/nginx-location-configuration-xiangxi-explain)

```
若用alias的话，http://网站/img/ = /alias_dir/
location /img/ {
    alias /alias_dir/;
}

若用root的话，http://网站/img/ = /root_dir/img/
location /img/ {
    root /root_dir/;
}
```
