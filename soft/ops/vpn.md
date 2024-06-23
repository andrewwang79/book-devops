# vpn
## 服务端
### 安装使用
* [CentOS8安装OpenVPN](https://blog.itnmg.net/2021/07/14/centos-8-openvpn/)
    * 采用https://raw.githubusercontent.com/Angristan/OpenVPN-install/master/openvpn-install.sh
    * 安装好后会自动生成客户端证书文件(.ovpn)
* 重启服务 : systemctl restart openvpn-server@server
* 状态查询 : systemctl status openvpn-server@server
* 配置文件路径是/etc/openvpn/server.conf，[配置项说明](http://blog.joylau.cn/2020/05/28/OpenVPN-Config/)

### 配置方法
* [单证书多人同时登录](http://www.99xyz.com/post/2021/11/39.html)：duplicate-cn
#### 全部IP都走VPN
```
push "redirect-gateway def1 bypass-dhcp"
push "dhcp-option DNS 94.140.14.14"
```
#### 配置的IP走VPN，其他走客户端网络
```
# push "redirect-gateway def1 bypass-dhcp"
# push "dhcp-option DNS 94.140.14.14"
push "route %IP% 255.255.255.255 vpn_gateway"
```

## 客户端
* [下载](https://openvpn.net/vpn-client/)
* 使用：加入客户端证书文件

## 软件安装时默认的证书两年会过期，解决方案
* 服务端：重新安装服务端软件。修改server.conf：用历史文件，两个属性(cert和key)用新生成的文件里的
* 客户端：使用新安装出来的ovpn文件