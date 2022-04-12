#!/bin/bash

wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
./bin/installdependencies.sh
curl --request POST 'https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token' --header "Authorization: token ${personal_access_token}" > output.json
runner_token="\$(jq -r '.token' output.json)"
sudo -u ubuntu mkdir /home/ubuntu/actions-runner
sudo -u ubuntu curl -o /home/ubuntu/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
sudo -u ubuntu tar xzf /home/ubuntu/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz -C /home/ubuntu/actions-runner
sudo -u ubuntu EC2_INSTANCE_ID=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id` bash -c 'cd /home/ubuntu/actions-runner/;./config.sh --url https://github.com/obynodavid12/Instances --token $runner_token --name "github-runner-$(hostname)" --unattended --replace
cd /home/ubuntu/actions-runner/;./svc.sh install
cd /home/ubuntu/actions-runner/;./svc.sh start
chown ubuntu -R /actions-runner

