#!/bin/bash
sudo apt-get update
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
mkdir ~/actions-runner
cd ~/actions-runner
curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
echo "Generating token"
RUNNER_TOKEN=$(curl -sX POST -H "Authorization: token ${PERSONAL_ACCESS_TOKEN}" https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token | jq -r '.token')
./config.sh --url https://github.com/obynodavid12/Instances --token ${RUNNER_TOKEN} --name "github-runner" --unattended --replace
echo "Running"
./run.sh
