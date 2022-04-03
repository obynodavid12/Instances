#!/bin/bash
sudo apt update -y
sudo apt install git -y
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
curl --request POST 'https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token' --header "Authorization: token ${personal_access_token}" > output.txt
echo "runner_token=\$(jq -r '.token' output.txt)"

export RUNNER_ALLOW_RUNASROOT="1"

sudo -u ubuntu mkdir /home/ubuntu/actions-runner 
sudo -u ubuntu cd /home/ubuntu/actions-runner

sudo -u ubuntu curl -O /home/ubuntu/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.298.2/actions-runner-linux-x64-2.298.2.tar.gz

sudo -u ubuntu tar xzf /home/ubuntu/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz -C /home/ubuntu/actions-runner

sudo -u ubuntu EC2_INSTANCE_ID=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id` bash -c 'cd /home/ubuntu/actions-runner/;./config.sh --url "https://github.com/obynodavid12/Instances/ --token \$runner_token --name "DEV-TEST-SELFHOSTED-RUNNER" --runasservice --unattended --replace

echo "Configured"

sudo ./svc.sh install

echo "Installed"

sudo ./svc.sh start

echo "Started"

