#!/bin/bash
cat <<EOF >/home/ubuntu/user-data.sh
#!/bin/bash
github_user="obynodavid12"
github_repo="Instances"
personal_access_token="${personal_access_token}"

wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
token=$(curl -s -XPOST -H "authorization: token $personal_access_token" https://api.github.com/repos/$github_user/$github_repo/actions/runners/registration-token | jq -r .token)
mkdir ~/actions-runner
cd ~/actions-runner
curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
rm ~/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz
~/actions-runner/config.sh --url https://github.com/obynodavid12/Instances/ --token \$token --name "DEV-TEST-SELFHOSTED-RUNNER" --unattended
~/actions-runner/run.sh
EOF
cd /home/ubuntu
chmod +x user-data.sh
bin/su -c "./user-data.sh" - ubuntu | tee /home/ubuntu/user-data.log
