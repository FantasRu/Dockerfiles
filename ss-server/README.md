# Shadowsocks

## Config
> https://github.com/shadowsocks/shadowsocks/wiki/Configuration-via-Config-File

## How to use
### Beforehand
```bash
docker pull pandazw/ss-server
```
### Run

```bash
$ docker run -d --name ss -v /root/ss/ssconfig.json:/etc/ssconfig.json -p 10000-10040:10000-10040 pandazw/ss-server && echo -n "Your IP is " && hostname -I | cut -d " " -f1
```
