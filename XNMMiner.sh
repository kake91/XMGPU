#!/bin/bash


# Update package list
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

# Clone the repository and build the project
echo "Cloning XENGPUMiner repository..."
git clone https://github.com/shanhaicoder/XENGPUMiner.git
cd XENGPUMiner || exit

echo "Building XENGPUMiner..."
chmod +x build.sh
./build.sh
sleep 5
echo "---------------------------"


# Enter Ethereum address in config.conf
echo "Enter your Ethereum address: "
read -r ethereum_address
sed -i "s/account = 0x24691e54afafe2416a8252097c9ca67557271475/account = $ethereum_address/g" config.conf

# Install Python requirements
echo "Installing Python requirements..."
sudo pip install -U -r requirements.txt


# Check the number of available GPUs
num_available_gpus=$(nvidia-smi --list-gpus | wc -l)
echo "You have $num_available_gpus GPU(s) available."



tmux new-session -d -s mining
sleep 5
echo "---------------------------"

tmux split-window -v
sleep 5
echo "---------------------------"

# Run the miner in the first pane
tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
sleep 5
echo "---------------------------"


tmux send-keys -t 1 'sudo chmod +x xengpuminer ' C-m
while true; do
  # Ask the user to enter the number of GPUs they want to use
  echo "Enter the number of GPUs you want to use (between 1 to $num_available_gpus , max number is 15):"
  read num_gpus

  # Check if the user's input is within the valid range
  if [[ $num_gpus -ge 1 && $num_gpus -le $num_available_gpus ]]; then
    echo "You have selected to use $num_gpus GPU(s)."
    # You can proceed with your GPU-related operations here.
    break  # Exit the loop if a valid input is provided.
  else
    echo "Error: You must enter a number between 1 and $num_available_gpus."
  fi
done

echo "---------------------------"

# Determine the number of GPUs to use

if [ "$num_gpus" -eq 1 ]; then
  # If the user selects 1 GPU
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer' C-m
elif [ "$num_gpus" -eq 2 ]; then
  # If the user selects 2 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1' C-m
elif [ "$num_gpus" -eq 3 ]; then
  # If the user selects 3 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2' C-m
elif [ "$num_gpus" -eq 4 ]; then
  # If the user selects 4 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3' C-m
elif [ "$num_gpus" -eq 5 ]; then
  # If the user selects 5 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4' C-m
elif [ "$num_gpus" -eq 6 ]; then
  # If the user selects 6 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5' C-m
elif [ "$num_gpus" -eq 7 ]; then
  # If the user selects 7 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6' C-m
elif [ "$num_gpus" -eq 8 ]; then
  # If the user selects 8 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6 & ./xengpuminer -d7' C-m
elif [ "$num_gpus" -eq 9 ]; then
  # If the user selects 9 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6 & ./xengpuminer -d7 & ./xengpuminer -d8' C-m
elif [ "$num_gpus" -eq 10 ]; then
  # If the user selects 10 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6 & ./xengpuminer -d7 & ./xengpuminer -d8 & ./xengpuminer -d9' C-m
elif [ "$num_gpus" -eq 11 ]; then
  # If the user selects 11 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6 & ./xengpuminer -d7 & ./xengpuminer -d8 & ./xengpuminer -d9 & ./xengpuminer -d10' C-m
elif [ "$num_gpus" -eq 12 ]; then
  # If the user selects 12 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6 & ./xengpuminer -d7 & ./xengpuminer -d8 & ./xengpuminer -d9 & ./xengpuminer -d10 & ./xengpuminer -d11' C-m
elif [ "$num_gpus" -eq 13 ]; then
  # If the user selects 13 GPUs
  tmux send-keys -t 1 'sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6 & ./xengpuminer -d7 & ./xengpuminer -d8 & ./xengpuminer -d9 & ./


sleep 5
echo "---------------------------"


