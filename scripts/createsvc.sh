#!/bin/bash
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.289.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.289.2/actions-runner-linux-x64-2.289.2.tar.gz# Optional: Validate the hash
echo "7ba89bb75397896a76e98197633c087a9499d4c1db7603f21910e135b0d0a238  actions-runner-linux-x64-2.289.2.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.289.2.tar.gz
