#!/bin/bash
apt update -y
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
curl --request POST 'https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token' --header "Authorization: token ${personal_access_token}" > output.txt
runner_token=\$(jq -r '.token' output.txt)
mkdir /home/ubuntu/actions-runner && cd /home/ubuntu/actions-runner || exit
curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
chown -R ubuntu /home/ubuntu/actions-runner
rm /home/ubuntu/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz
REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
sudo -i u ubuntu bash << EOF
/home/ubuntu/actions-runner/config.sh --url https://github.com/obynodavid12/Instances/ --token \$runner_token --name "DEV-TEST-SELFHOSTED-RUNNER" --unattended
EOF
echo "Configured"
sudo ./svc.sh install
echo "Installed"
sudo ./svc.sh start
echo "Started"
