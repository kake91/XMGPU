#!/bin/bash

#this script by @al_kake91

# Function to install all the packages using apt
install_package() {
    package_name="$1"
    echo "Installing $package_name..."
    if ! sudo apt-get install -y "$package_name"; then
        echo "Failed to install $package_name. Aborting."
        exit 1
    fi
}

# To update package list
echo "Updating package list..."
if ! sudo apt update; then
    echo "Failed to update package list. Aborting."
    exit 1
fi

# Install required packages
install_package "ocl-icd-opencl-dev"
install_package "nano"
install_package "tmux"
install_package "cmake"
install_package "python3-pip"
install_package "git"

# Clone the repository of XENGPUMiner
echo "Cloning XENGPUMiner repository..."
git clone https://github.com/shanhaicoder/XENGPUMiner.git
cd XENGPUMiner || exit

# Enter address in config.conf
echo "Enter your address with mine Xenium with: "
read -r address
sed -i "s/account = 0x24691e54afafe2416a8252097c9ca67557271475/account = $address/g" config.conf

# To install Python requirements
echo "Installing Python requirements..."
sudo pip install -U -r requirements.txt

echo "Building XENGPUMiner..."
chmod +x build.sh
./build.sh

# The script Checking the number of available GPUs
num_available_gpus=$(nvidia-smi --list-gpus | wc -l)

if [ $num_available_gpus -eq 0 ]; then
    echo "No GPUs available. Aborting."
    exit 1
fi

echo "The total available GPUs: $num_available_gpus"

# Prompt the user to choose the number of GPUs to use
while true; do
    read -p "Enter the number of GPUs you want to use (1-$num_available_gpus): " num_gpus
    if [ $num_gpus -ge 1 ] && [ $num_gpus -le $num_available_gpus ]; then
        break
    else
        echo "Your choice is not valide please choose a number between 1 and $num_available_gpus."
    fi
done

echo "You chose to use $num_gpus GPU(s)."

# Run XENGPUMiner based on the number of GPUs selected
echo "Running XENGPUMiner for $num_gpus GPU(s)..."
python3 miner.py --gpu=true & sleep 2

tmux new-session -d -s miner-session

#split the screen vertically
tmux split-window -v

# Prepare the command for running XENGPUMiner for all GPUs on a single line
cmd="sudo chmod +x xengpuminer &&"
for ((i = 0; i < num_gpus; i++)); do
    cmd="$cmd ./xengpuminer -d$i"
    if [ $i -lt $((num_gpus - 1)) ]; then
        cmd="$cmd &"
    fi
done

# Run the combined command in a single pane
tmux send-keys -t 1 "$cmd" C-m
