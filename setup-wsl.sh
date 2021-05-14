#!/bin/bash

# suppress daily login message
touch ~/.hushlogin

# dir this script is in
file_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo update-alternatives --set editor /usr/bin/vim.basic

# no password for sudo
sudo_config_str="${USER} ALL=(ALL) NOPASSWD: ALL"
if ! sudo grep -qxF "${sudo_config_str}" /etc/sudoers; then
  sudo cp /etc/sudoers /etc/sudoers.backup
  echo "sudoer file is backed up at: /etc/sudoers.backup"
  echo ${sudo_config_str} | sudo tee --append /etc/sudoers
fi

sudo apt-get update
sudo apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git software-properties-common

cat <<EOF | sudo tee /etc/apt/sources.list
deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse

EOF
sudo apt update

if [ ! -d ~/miniconda3 ]; then
  wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
  bash /tmp/miniconda.sh -b
fi

cp ${file_dir}/.bashrc ~/.bashrc
source ~/.bashrc

# pip mirrors
pip config set global.index-url  https://mirrors.aliyun.com/pypi/simple/
pip install pip -U

# conda configs
cp ${file_dir}/.condarc ~/.condarc

./setup_jetbrains_ssh
