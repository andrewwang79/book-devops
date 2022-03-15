# vpn
## 服务端
### 安装使用
* [CentOS8安装OpenVPN](https://blog.itnmg.net/2021/07/14/centos-8-openvpn/)，
* systemctl restart openvpn-server@server

### 配置
* 配置文件在/etc/openvpn/server.conf，[配置项说明](http://blog.joylau.cn/2020/05/28/OpenVPN-Config/)
* [openvpn设置单证书多人同时登录](http://www.99xyz.com/post/2021/11/39.html)：duplicate-cn
* 都走VPN及其DNS
```
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 94.140.14.14"
```
* 指定的IP走VPN，走客户端DNS
```
# push "redirect-gateway def1 bypass-dhcp"
# push "dhcp-option DNS 94.140.14.14"
push "route IP 255.255.255.255 vpn_gateway"
```

## 客户端
### 安装使用
* [下载](https://openvpn.net/vpn-client/)，加入证书
