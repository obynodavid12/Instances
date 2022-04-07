#/bin/bash

set -e

mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz
echo "7ba89bb75397896a76e98197633c087a9499d4c1db7603f21910e135b0d0a238  actions-runner-linux-x64-2.289.2.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
./config.sh --url https://github.com/obynodavid12/Instances --token AQSVU6H25MNFUNFURWXLZETCJ5QPG
./run.sh




















#!/bin/bash
# cat <<EOF >/home/ubuntu/user-data.sh
# #!/bin/bash
# wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
# chmod +x ./jq
# sudo cp jq /usr/bin
# curl --request POST 'https://api.github.com/repos/obynodavid12/Instances/actions/runners/registration-token' --header "Authorization: token ${personal_access_token}" > output.txt
# runner_token=$(jq -r '.token' output.txt)
# mkdir ~/actions-runner
# cd ~/actions-runner
# curl -o actions-runner-linux-x64-2.289.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.1/actions-runner-linux-x64-2.289.1.tar.gz
# tar xzf ./actions-runner-linux-x64-2.289.1.tar.gz
# rm ~/actions-runner/actions-runner-linux-x64-2.289.1.tar.gz
# ~/actions-runner/config.sh --url https://github.com/obynodavid12/Instances/ --token \$runner_token --name "DEV-TEST-SELFHOSTED-RUNNER" --unattended
# ~/actions-runner/run.sh
# EOF
# cd /home/ubuntu
# chmod +x user-data.sh
# bin/su -c "./user-data.sh" - ubuntu | tee /home/ubuntu/user-data.log
