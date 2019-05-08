# ss-privoxy

Connect shadowsocks server in terminal(cloud server).

### Usage

```bash
docker run -d --name ss-privoxy -p 1081:1081  \
  -e "SERVER_ADDR=ss.*.com" \
  -e "METHOD=aes-256-cfb" \
  -e "PASSWORD=*" \
  -e "SSPORT=8081" \
  -e "PROXYPORT=1081" pandazw/ss-privoxy:v1
```

### Tests
```bash
curl ip.gs --proxy http://localhost:1081
```