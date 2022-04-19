#!/bin/bash
sudo apt-get update -y
wget -O jq https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64
chmod +x ./jq
sudo mv jq /usr/bin
export RUNNER_CFG_PAT="${{ secrets.RUNNER_CFG_PAT }}"
curl -s https://raw.githubusercontent.com/actions/runner/main/scripts/create-latest-svc.sh | bash -s -- -s obynodavid12/Instances -n gbrunner -l gpu,x64,linux

