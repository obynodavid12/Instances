#!/bin/bash
cat <<EOF >/home/ubuntu/user-data.sh
#!/bin/bash
sudo apt-get update
sudo apt-get install git
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
curl --request POST 'https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token' --header "Authorization: token ${personal_access_token}" > output.txt
runner_token=\$(jq -r '.token' output.txt)

export RUNNER_ALLOW_RUNASROOT="1"

mkdir actions-runner && cd actions-runner

curl -O -L https://github.com/actions/runner/releases/download/v2.298.2/actions-runner-linux-x64-2.298.2.tar.gz

tar xzf ./actions-runner-linux-x64-2.298.2.tar.gz

./config.sh --url "https://github.com/obynodavid12/Instances/ --token \$runner_token --name "DEV-TEST-SELFHOSTED-RUNNER" --runasservice --unattended --replace

echo "Configured"

sudo ./svc.sh install

echo "Installed"

sudo ./svc.sh start

echo "Started"
EOF
cd /home/ubuntu
chmod +x user-data.sh
bin/su -c "./user-data.sh" -ubuntu | tee /home/ubuntu/user-data.log



