# Ubuntu 16.04 docker-ce 升级

# Uninstall docker-ce
```bash
sudo apt remove docker-ce docker-ce-cli
```

## Prerequisite
安装 `nvidia-docker` 前需先安装以下模块:
- [nvidia-driver](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1604&target_type=deblocal)
- docker
  - [libseccomp2](http://ftp.sjtu.edu.cn/ubuntu/pool/main/libs/libseccomp/libseccomp2_2.4.3-1ubuntu3.16.04.3_amd64.deb)
  - [containerd.io](https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/containerd.io_1.4.6-1_amd64.deb)
  - [docker-ce-cli](https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce-cli_20.10.7~3-0~ubuntu-xenial_amd64.deb)
  - [docker-ce](https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce_20.10.7~3-0~ubuntu-xenial_amd64.deb)
- [docker-compose](https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64)

Then download these file:

- [libnvidia-container1_1.5.0-1_amd64.deb](https://github.com/NVIDIA/libnvidia-container/raw/gh-pages/stable/ubuntu16.04/amd64/libnvidia-container1_1.5.0-1_amd64.deb)
- [libnvidia-container-tools_1.5.0-1_amd64.deb](https://github.com/NVIDIA/libnvidia-container/raw/gh-pages/stable/ubuntu16.04/amd64/libnvidia-container-tools_1.5.0-1_amd64.deb)
- [nvidia-container-toolkit_1.5.0-1_amd64.deb](https://github.com/NVIDIA/nvidia-container-runtime/raw/gh-pages/stable/ubuntu16.04/amd64/nvidia-container-toolkit_1.5.0-1_amd64.deb)
- [nvidia-container-runtime_3.5.0-1_amd64.deb](https://github.com/NVIDIA/nvidia-container-runtime/raw/gh-pages/stable/ubuntu16.04/amd64/nvidia-container-runtime_3.5.0-1_amd64.deb)
- [nvidia-docker2_2.6.0-1_all.deb](https://github.com/NVIDIA/nvidia-docker/raw/gh-pages/ubuntu16.04/amd64/nvidia-docker2_2.6.0-1_all.deb)

## Instruction
### Nvidia 驱动安装
略

### 离线安装 docker 与 docker-compose
```bash
sudo dpkg -i libseccomp2_2.4.3-1ubuntu3.16.04.3_amd64.deb
sudo dpkg -i containerd.io_1.4.6-1_amd64.deb
sudo dpkg -i docker-ce-cli_20.10.7_3-0_ubuntu-xenial_amd64.deb
sudo dpkg -i docker-ce_20.10.7_3-0_ubuntu-xenial_amd64.deb

sudo mv docker-compose-Linux-x86_64 /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### 安装 nvidia-docker2
```bash
sudo dpkg -i libnvidia-container1_1.5.0-1_amd64.deb
sudo dpkg -i libnvidia-container-tools_1.5.0-1_amd64.deb
# sudo dpkg -i nvidia-container-toolkit_1.5.0-1_amd64.deb
# 此处可能出现版本冲突（历史安装版本），使用参数 --auto-deconfigure
sudo dpkg -i --auto-deconfigure nvidia-container-toolkit_1.5.0-1_amd64.deb
sudo dpkg -i nvidia-container-runtime_3.5.0-1_amd64.deb
sudo dpkg -i nvidia-docker2_2.6.0-1_all.deb
```

重启 docker:
```bash
sudo systemctl restart docker
```
测试 GPU 功能:
```bash
sudo docker load -i cuda_11_base.tar # 自行下载 nvidia/cuda:11.0-base 镜像并保存
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```
