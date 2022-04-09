#!/bin/bash
cat <<EOF >/home/ubuntu/user-data.sh
#!/bin/bash
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo cp jq /usr/bin
registration_url="https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token"
echo "Requesting registration URL at '${registration_url}'"
payload=$(curl -sX POST -H "Authorization: token ${personal_access_toekn}" ${registration_url})
export TOKEN=$(echo $payload | jq .token --raw-output)
mkdir ~/actions-runner
cd ~/actions-runner
curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
tar -xzf ./actions-runner-linux-x64-2.289.2.tar.gz
rm ~/actions-runner/actions-runner-linux-x64-2.289.2.tar.gz
~/actions-runner./config.sh --url https://github.com/obynodavid12/Instances/ --token \$TOKEN --name "selfhosted-runner" --unattended --replace
~/actions-runner/.run.sh 
EOF
cd /home/ubuntu
chown -R ubuntu
chmod +x user-data.sh
/bin/su -c "./user-data.sh" - ubuntu | tee /home/ubuntu/user-data.log



