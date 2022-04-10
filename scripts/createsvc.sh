#!/bin/bash
sudo apt-get update -y
mkdir /home/ubuntu/actions-runner && cd /home/ubuntu/actions-runner || exit
# Download the latest runner package
curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
# Extract the installer
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
chown -R ubuntu /home/ubuntu/actions-runner




