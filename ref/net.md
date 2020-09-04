# 网络知识

* [ip段和掩码说明，如24](http://www.nocidc.com/News/New-96.html)
* Socket的四个构成：服务端地址、服务端端口、客户端地址、客户端端口。1台服务器可以同时支持远超65536个socket/请求
* websocket是socket，也可以支持N个。如使用了nginx作为代理，则因为nginx作为remoteIp只有1个，导致websocket连接数最多六万多
