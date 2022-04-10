#!/bin/bash
github_user="obynodavid12"
github_repo="Instances"
personal_access_token="${personal_access_token}"

sudo apt-get update -y
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
# Get the latest runner version
VERSION_FULL=$(curl -s https://api.github.com/repos/actions/runner/releases/latest | jq -r .tag_name)
RUNNER_VERSION="2.289.2"


# Create a folder
mkdir /home/ubuntu/actions-runner && cd /home/ubuntu/actions-runner || exit
# Download the latest runner package
curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
# Extract the installer
tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz
chown -R ubuntu /home/ubuntu/actions-runner

token=$(curl -s -XPOST -H "authorization: token $personal_access_token" https://api.github.com/repos/$github_user/$github_repo/actions/runners/registration-token | jq -r .token)
sudo -i -u ubuntu bash << EOF
/home/ubuntu/actions-runner/config.sh --url https://github.com/obynodavid12/$github_user --token $token --name gh-g2-runner-"${hostname}" --work /home/ubuntu/actions-runner --unattended
EOF
./svc.sh install
./svc.sh start
