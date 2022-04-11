#!/bin/bash
sudo apt-get update -y
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
sudo usermod -a -G docker ubuntu
export RUNNER_ALLOW_RUNASROOT=true
mkdir actions-runner
cd actions-runner
curl -O -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
PERSONAL_ACCESS_TOKEN=${PERSONAL_ACCESS_TOKEN}
INSTANCEID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
echo my-runners-$INSTANCEID
token=$(curl -s -XPOST -H "authorization: token $PERSONAL_ACCESS_TOKEN" https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token | jq -r '.token')
sudo chown ubuntu -R /actions-runner
./config.sh --url https://github.com/obynodavid12/Instances --token $token --name "my-runners-$INSTANCEID" --work _work
sudo ./svc.sh install
sudo ./svc.sh start
sudo chown ubuntu -R /actions-runner
