# openresty
## 安装运行
* docker pull openresty/openresty:1.19.3.1-1-buster-fat
* docker run --name openresty -p 580:80 -p 5443:443 -di openresty/openresty:1.19.3.1-1-buster-fat

## 开发
### nginx
```
upstream gray_service {
    server 192.168.1.2:80;
}
upstream current_service {
    server 192.168.1.3:80;
}
server {
    listen 80;
    server_name _;
    location / {
        default_type 'text/plain';
        lua_code_cache off; // 正式要on
        content_by_lua_file /etc/nginx/conf/lua/gray.lua;   ## 访问网站交给这个lua脚本
    }
    location @gray_service {
        proxy_pass http://gray_service/;
        proxy_set_header Host $http_host;
    }
    location @current_service {
        proxy_pass http://current_service/;
        proxy_set_header Host $http_host;
    }
}
```

### lua
```
local request_method = ngx.var.request_method
if "GET" == request_method then
    args = ngx.req.get_uri_args()
elseif "POST" == request_method then
    ngx.req.read_body()
    args = ngx.req.get_post_args()
    Body = ngx.req.get_body_data()
end
```

## 资料
* [docker安装openresty](https://blog.csdn.net/qq_42236935/article/details/106905970)
* [灰度发布](https://www.jianshu.com/p/bd43db39c5a3)
