#!/bin/bash

github_user="obynodavid12"
github_repo="Instances"
personal_access_token="${personal_access_token}"

# Download jq for extracting the Token
apt-get install jq -y

# Create and move to the working directory
mkdir /actions-runner && cd /actions-runner

# Download the latest runner package
curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz

# Extract the installer
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz

# Change the owner of the directory to ubuntu
chown ubuntu -R /actions-runner

# Get the runner's token
token=$(curl -s -XPOST -H "authorization: token $personal_access_token" https://api.github.com/repos/$github_user/$github_repo/actions/runners/registration-token | jq -r .token)

# Create the runner and start the configuration experience
sudo -u ubuntu ./config.sh --url https://github.com/obynodavid12/$github_user --token $token --name "github-runner-$(hostname)" --unattended
