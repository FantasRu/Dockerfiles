# Shadowsocks

## shadowsocks config
> https://github.com/shadowsocks/shadowsocks/wiki/Configuration-via-Config-File

## Build
> docker build -t ss --build-arg arg=https://cdn.yourdomain.com/ssconfig.json .

Or

>  docker build -t ss .

## Run
> docker run -d -p 10000-10020:10000-10020 ss && hostname -I 

