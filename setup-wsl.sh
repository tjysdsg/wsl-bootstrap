#!/bin/bash

# dir this script is in
file_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sudo update-alternatives --set editor /usr/bin/vim.basic
sudo cp /etc/sudoers /etc/sudoers.backup
echo "sudoer file is backed up at: /etc/sudoers.backup"
echo "${USER} ALL=(ALL) NOPASSWD: ALL" | sudo tee --append /etc/sudoers

sudo apt-get update --fix-missing
sudo apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh
bash /tmp/miniconda.sh -b
cp ${file_dir}/.bashrc ~/.bashrc
