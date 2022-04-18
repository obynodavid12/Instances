#!/bin/bash
sudo apt update -y
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
sudo -u ubuntu mkdir /home/ubuntu/actions-runner
sudo -u ubuntu curl -o /home/ubuntu/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
sudo -u ubuntu tar xzf /home/ubuntu/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz -C /home/ubuntu/actions-runner
sudo -u ubuntu EC2_INSTANCE_ID=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id` bash -c 'cd /home/ubuntu/actions-runner/;./config.sh --url https://github.com/obynodavid12/Instances  --PERSONAL_ACCESS_TOKEN ${PERSONAL_ACCESS_TOKEN} --name "github-runner"-$${EC2_INSTANCE_ID}" --work _work --labels ${labels} --runasservice'

# start the github runner as a service on startup
cd /home/ubuntu/actions-runner/;./svc.sh install
cd /home/ubuntu/actions-runner/;./svc.sh start


