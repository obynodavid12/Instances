#!/bin/bash

set -e

flags_found=false

while getopts t:o: option
do
case "${option}"
in
t) GITHUBTOKEN=${OPTARG};;
o) GITHUBORG=${OPTARG};;
esac
done

export RUNNER_ALLOW_RUNASROOT="1"

mkdir actions-runner && cd actions-runner

curl -O -L https://github.com/actions/runner/releases/download/v2.298.2/actions-runner-linux-x64-2.298.2.tar.gz

tar xzf ./actions-runner-linux-x64-2.298.2.tar.gz

./config.sh --url "https://github.com/$GITHUBORG" --token $GITHUBTOKEN --runasservice --unattended --replace

echo "Configured"

sudo ./svc.sh install

echo "Installed"

sudo ./svc.sh start

echo "Started"
