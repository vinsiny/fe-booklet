<!-- ---
tags: [11月的]
title: HTTPS
created: '2019-10-29T08:58:43.304Z'
modified: '2019-11-18T06:45:55.999Z'
--- -->

# HTTPS

### 服务器端生成数字证书

1. 生成本地密钥对；
2. 发送公钥和其他基本信息到 **CA认证中心** 生成数据证书；

### CA 认证中心：

1. 采用单向hash算法对公钥和基本信息进行摘要算法；

2. 用私匙对摘要进行加密，生成数字签名；

3. 将申请信息（包含服务器的公匙）和数字签名整合在一起，生成数字证书；

4. 返回数字证书；

### 使用数字证书 协商对称加密密钥

1. server 将数字证书发送个 client；

2. client 通过 CA 公钥解密出摘要信息，并用相同的 hash 算法对 sever 的申请信息生成摘要，比对摘要信息。

3. 如果相同则说明内容完整，没有被篡改， client 使用公钥加密生成的对称密钥；

4. server 使用私钥解密 client 的密文，得到对称加密密钥；

5. server 和 client 使用对称加密的方式进行后续通信；

### 为何不能被窃听和篡改

1. 不能窃听

  攻击者截获 client 使用公钥加密生成的对称密钥，因为没有 server 的私钥，所以无法解密出对称密钥；

2. 不能篡改
  
  攻击者截获 server 的数字证书，可以通过 CA 公钥解密出摘要信息和 server 的公钥，但没有 CA 的私钥，所以无法重新篡改报文。
