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

echo "Enter your Ethereum address: "
read ethereum_address
sed -i "s/account = 0x24691e54afafe2416a8252097c9ca67557271475/account = $ethereum_address/g" config.conf
sleep 5
echo "---------------------------"

# Install Python requirements
sudo pip install -U -r requirements.txt
sleep 5
echo "---------------------------"



# Check the number of available GPUs
num_available_gpus=$(nvidia-smi --query-gpu=count --format=csv,noheader,nounits)
echo "You have $num_available_gpus GPU(s) available."

while true; do
  # Ask the user to enter the number of GPUs they want to use
  echo "Enter the number of GPUs you want to use (between 1 to $num_available_gpus):"
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

# Rest of your script
echo "---------------------------"



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




gpu_counter=0  # Initialize a counter for the GPUs used

while [ "$gpu_counter" -lt "$num_gpus" ]; do
  # Increment the GPU counter and send the corresponding command
  gpu_command="cd XENGPUMiner && sudo chmod +x xengpuminer && ./xengpuminer -d$gpu_counter"
  tmux send-keys -t 1 "$gpu_command" C-m
  ((gpu_counter++))
done

sleep 5
echo "---------------------------"








