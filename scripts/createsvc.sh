#!/bin/bash -xe
         
apt update -y 
apt install git -y
apt install jq -y 
sudo usermod -a -G docker ubuntu
sudo systemctl start docker
sudo systemctl enable docker
export RUNNER_ALLOW_RUNASROOT=true
mkdir actions-runner
cd actions-runner
curl -O actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.298.2/actions-runner-linux-x64-2.298.2.tar.gz
tar xzf ./actions-runner-linux-x64-2.298.2.tar.gz
PERSONAL_ACCESS_TOKEN=${personal_access_token}
token=$(curl -s -XPOST \
    -H "authorization: token $personal_access_token" \
     https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token |\
     jq -r .token)
sudo chown ubuntu -R /actions-runner
./config.sh --url https://github.com/obynodavid12/Instances --token $token --name "DEV-TEST-SELFHOSTED-RUNNER-$(hostname)" --work _work
sudo ./svc.sh install
sudo ./svc.sh start
sudo chown ubuntu -R /actions-runner
