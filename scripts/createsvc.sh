#!/bin/bash
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
export runner_token=$(curl -s -X POST https://api.github.com/obynodavid12/Instances/actions/runners/registration-token -H "accept: application/vnd.github.everest-preview+json" -H "authorization: token ${personal_access_token}" | jq -r '.token')
mkdir ~/actions-runner
cd ~/actions-runner
curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
rm ~/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz
chown -R ubuntu /home/ubuntu/actions-runner
sudo -E -u ubuntu ./config.sh --url https://github.com/obynodavid12/Instances --token $runner_token --name "github-runner" --unattended
sudo ./svc.sh install ubuntu
sudo ./svc.sh start
