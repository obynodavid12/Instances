#!/bin/bash
sudo apt-get update -y
sudo apt-get install curl -y
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
runner_token=$(curl --request POST 'https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token' --header "Authorization: token ${personal_access_token}" | jq -r '.token')
mkdir /home/ubuntu/actions-runner && cd /home/ubuntu/actions-runner || exit
curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
chown -R ubuntu /home/ubuntu/actions-runner
sudo -i -u ubuntu bash << EOF
/home/ubuntu/actions-runner/config.sh --url https://github.com/obynodavid12/Instances --token "${runner_token}" --name "github-runner" --unattended
EOF
./svc.sh install
./svc.sh start


