#!/bin/bash 
sudo apt-get update -y
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
export RUNNER_ALLOW_RUNASROOT=true
mkdir actions-runner
cd actions-runner
curl -O -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
RUNNER_TOKEN=$(curl -s -XPOST -H "authorization: token $PERSONAL_ACCESS_TOKEN" https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token | jq -r .token)
sudo chown ubuntu -R /actions-runner
./config.sh --url https://github.com/obynodavid12/Instances --token $RUNNER_TOKEN --name "my-runner-$(hostname)" --runasservice --unattended --replace 
sudo ./svc.sh install
sudo ./svc.sh start
echo "Started"
sudo chown ubuntu -R /actions-runner
