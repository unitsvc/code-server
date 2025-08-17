#!/bin/bash

git clone https://gitee.com/unitsvc/code-server
cd code-server
git checkout build/250818-3991

# step 1
git config -f .gitmodules submodule.lib/vscode.url https://gitee.com/microsoft/vscode.git
git submodule sync
git submodule update --init --recursive

# step 2
export PROXY_PREFIX=https://ghfast.top

curl -o- $PROXY_PREFIX/https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc
source ~/.bashrc

nvm install 22.17.0
nvm use 22.17.0

# step 3
sudo apt update
sudo apt install jq
sudo apt install gcc-11 g++-11 -y
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 100
sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-11 100
g++ --version

# step 4
npm install -g nrm
nrm use huawei

npm install
npm run build

export VERSION=v4.103.1
npm run package
