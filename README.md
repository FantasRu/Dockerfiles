# Dockerfiles

## Docker
### Install using the repository
```bash
$ sudo apt update && sudo apt upgrade 
$ sudo apt install docker.io
```
### Manage Docker as a non-root user 
```bash
$ sudo groupadd docker
$ sudo gpasswd -a $USER docker
$ newgrp docker
```

## Docker Engine Utility for NVIDIA GPUs
## Prerequisites
### Install Cuda on Ubuntu

####  install dependences
```bash
 $ sudo apt-get update && apt-get upgrade 
 $ sudo apt install gcc
 $ sudo apt install build-essential
```
#### CUDA Install 
* [Download CUDA](https://developer.nvidia.com/cuda-downloads): `runfile (local)`
* Check the md5 sum: `md5sum cuda_9.1.85_387.26_linux.run`

```bash
$ sudo sh cuda_9.1.85_387.26_linux --override
```

#### CUDA Environment

```bash
$ sudo emacs -nw /etc/ld.so.conf.d/cuda.conf
/usr/local/cuda-9.1/lib64
$ sudo emacs -nw ~/.bash_profile
export PATH=$PATH:/usr/local/cuda-9.1/bin
$ source ~/.bash_profile
```

#### Verify CUDA installation

```bash
$ nvcc -V
$ nvidia-smi
```

### Docker CE
#### Uninstall old versions
```bash
$ sudo apt remove docker docker-engine docker.io
```
#### Install using the repository

```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"

sudo apt install docker-ce
```

## NVIDIA-docker(version 2.0)
### add Ubuntu distributions
```bash
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```
### Install
```bash
sudo apt update
sudo apt install nvidia-docker2
sudo pkill -SIGHUP dockerd
```

### Usage
```bash
docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
```

### Registry

TODO: *daocloud.io*