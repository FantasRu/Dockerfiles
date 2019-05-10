# Shadowsocks

## Config
> https://github.com/shadowsocks/shadowsocks/wiki/Configuration-via-Config-File

## How to use
### Beforehand
```bash
$ wget https://raw.githubusercontent.com/FantasRu/Dockerfiles/master/ssserver/Dockerfile
```
### Build
```bash
$ docker build -t ss --build-arg arg=https://cdn.yourdomain.com/ssconfig.json .
```
Or use the default config.
```bash
$ docker build -t ss --build-arg arg=https://raw.githubusercontent.com/FantasRu/Dockerfiles/master/ssserver/ssconfig.json .
```
Also, you can put the specific `ssconfig.json` along with Dockerfile
```bash
$ docker build -t ss .
```
### Run

```bash
$ docker run -d --name ss -v /root/ss/ssconfig.config:/etc/ssconfig.config -p 10000-10040:10000-10040 ss && echo -n 
"Your IP is " && hostname -I | cut -d " " -f1```
