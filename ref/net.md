# 网络知识
* [互联网通讯原理](https://segmentfault.com/a/1190000023316912)
  * 核心概念是交换和路由
  * 路由：请求通过路由表跳跃到下个点，路由算法会动态维护网络拓扑
  * 通过自治系统简化网络复杂度，本质是多层网络，可以简化路由表和路由算法。
* [ip段和掩码说明，如24](http://www.nocidc.com/News/New-96.html)

## Socket
* Socket的四个构成：服务端地址、服务端端口、客户端地址、客户端端口。1台服务器可以同时支持远超65536个socket/请求

## Websocket
* Websocket是socket，也可以支持N个。如使用了nginx作为代理，则因为nginx作为remoteIp只有1个，导致websocket连接数最多六万多
* [Websocket推送中心(三)-单机100W连接(C1000K)达成](https://shibd.github.io/2019/08/17/Message-Center-3/)
