#!/bin/bash


sudo apt update
sleep 5
echo "---------------------------"

sudo apt -y install ocl-icd-opencl-dev
sleep 5
echo "---------------------------"

sudo apt -y install nano
sleep 5
echo "---------------------------"

sudo apt -y install tmux
sleep 5
echo "---------------------------"

sudo apt -y install cmake
sleep 5
echo "---------------------------"

sudo apt -y install python3-pip
sleep 5
echo "---------------------------"

# Clone the repository and build the project
git clone https://github.com/shanhaicoder/XENGPUMiner.git
sleep 5
echo "---------------------------"

cd XENGPUMiner
sleep 5
echo "---------------------------"

chmod +x build.sh
sleep 5
echo "---------------------------"

./build.sh
sleep 5
echo "---------------------------"

# Update the configuration file
sed -i 's/account = 0x24691e54afafe2416a8252097c9ca67557271475/account = 0x129c24df1bD82BC2ce9f461063af011662926bA5/g' config.conf
sleep 5
echo "---------------------------"

# Install Python requirements
sudo pip install -U -r requirements.txt
sleep 5
echo "---------------------------"

tmux new-session -d -s mining
sleep 5
echo "---------------------------"

tmux split-window -v
sleep 5
echo "---------------------------"

# Run commands in separate panes
tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
sleep 5
echo "---------------------------"

tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6 & ./xengpuminer -d7' C-m
sleep 5
echo "---------------------------"
