
#!/bin/bash

# Function to install packages using apt
install_package() {
    package_name="$1"
    echo "Installing $package_name..."
    if ! sudo apt-get install -y "$package_name"; then
        echo "Failed to install $package_name. Aborting."
        exit 1
    fi
}

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

# Clone the repository of XENGPUMiner
echo "Cloning XENGPUMiner repository..."
git clone https://github.com/shanhaicoder/XENGPUMiner.git
cd XENGPUMiner || exit

# Enter  address in config.conf
echo "Enter your address: "
read -r address
sed -i "s/account = 0x24691e54afafe2416a8252097c9ca67557271475/account = $address/g" config.conf

# Install Python requirements
echo "Installing Python requirements..."
sudo pip install -U -r requirements.txt

echo "Building XENGPUMiner..."
chmod +x build.sh
./build.sh

# Check the number of available GPUs
num_available_gpus=$(nvidia-smi --list-gpus | wc -l)

if [ $num_available_gpus -eq 0 ]; then
    echo "No GPUs available. Aborting."
    exit 1
fi

if [ $num_available_gpus -eq 1 ]; then
    # If there is 1 GPU, execute xengpuminer for that GPU
    echo "Running XENGPUMiner for 1 GPU..."
    tmux new-session -d -s miner-session
    sleep 5
    echo "---------------------------"
    
    # Split the screen
    tmux split-window -v
    sleep 5
    echo "---------------------------"

    # Running the python miner
    tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
    sleep 20
    echo "---------------------------"
    
    # Running the GPU miner
    tmux send-keys -t 1 'cd XENGPUMiner sudo chmod +x xengpuminer && ./xengpuminer' C-m
    sleep 5
    echo "---------------------------"
    
fi

if [ $num_available_gpus -eq 2 ]; then
    # If there are 2 GPUs, execute xengpuminer for both GPUs
    echo "Running XENGPUMiner for 2 GPUs..."
    tmux new-session -d -s miner-session
    sleep 5
    echo "---------------------------"
    
    # Split the screen
    tmux split-window -v
    sleep 5
    echo "---------------------------"

    # Running the python miner
    tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
    sleep 20
    echo "---------------------------"
    
    # Running the GPU miner for GPU 0 and GPU 1
    tmux send-keys -t 1 'cd XENGPUMiner sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1' C-m
    sleep 5
    echo "---------------------------"
    
fi

if [ $num_available_gpus -eq 3 ]; then
    # If there are 3 GPUs, execute xengpuminer for all three GPUs
    echo "Running XENGPUMiner for 3 GPUs..."
    tmux new-session -d -s miner-session
    sleep 5
    echo "---------------------------"
    
    # Split the screen
    tmux split-window -v
    sleep 5
    echo "---------------------------"

    # Running the python miner
    tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
    sleep 20
    echo "---------------------------"
    
    # Running the GPU miner for GPU 0, GPU 1, and GPU 2
    tmux send-keys -t 1 'cd XENGPUMiner sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2' C-m
    sleep 5
    echo "---------------------------"
fi

if [ $num_available_gpus -eq 4 ]; then
    # If there are 4 GPUs, execute xengpuminer for all four GPUs
    echo "Running XENGPUMiner for 4 GPUs..."
    tmux new-session -d -s miner-session
    sleep 5
    echo "---------------------------"
    
    # Split the screen
    tmux split-window -v
    sleep 5
    echo "---------------------------"

    # Running the python miner
    tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
    sleep 20
    echo "---------------------------"
    
    # Running the GPU miner for GPU 0, GPU 1, GPU 2, and GPU 3
    tmux send-keys -t 1 'cd XENGPUMiner sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3' C-m
    sleep 5
    echo "---------------------------"
fi

if [ $num_available_gpus -eq 5 ]; then
    # If there are 5 GPUs, execute xengpuminer for all five GPUs
    echo "Running XENGPUMiner for 5 GPUs..."
    tmux new-session -d -s miner-session
    sleep 5
    echo "---------------------------"
    
    # Split the screen
    tmux split-window -v
    sleep 5
    echo "---------------------------"

    # Running the python miner
    tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
    sleep 20
    echo "---------------------------"
    
    # Running the GPU miner for GPU 0, GPU 1, GPU 2, GPU 3, and GPU 4
    tmux send-keys -t 1 'cd XENGPUMiner sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4' C-m
    sleep 5
    echo "---------------------------"
fi

if [ $num_available_gpus -eq 6 ]; then
    # If there are 6 GPUs, execute xengpuminer for all six GPUs
    echo "Running XENGPUMiner for 6 GPUs..."
    tmux new-session -d -s miner-session
    sleep 5
    echo "---------------------------"
    
    # Split the screen
    tmux split-window -v
    sleep 5
    echo "---------------------------"

    # Running the python miner
    tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
    sleep 20
    echo "---------------------------"
    
    # Running the GPU miner for GPU 0, GPU 1, GPU 2, GPU 3, GPU 4, and GPU 5
    tmux send-keys -t 1 'cd XENGPUMiner sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5' C-m
    sleep 5
    echo "---------------------------"
fi

if [ $num_available_gpus -eq 7 ]; then
    # If there are 7 GPUs, execute xengpuminer for all seven GPUs
    echo "Running XENGPUMiner for 7 GPUs..."
    tmux new-session -d -s miner-session
    sleep 5
    echo "---------------------------"
    
    # Split the screen
    tmux split-window -v
    sleep 5
    echo "---------------------------"

    # Running the python miner
    tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
    sleep 20
    echo "---------------------------"
    
    # Running the GPU miner for GPU 0, GPU 1, GPU 2, GPU 3, GPU 4, GPU 5, and GPU 6
    tmux send-keys -t 1 'cd XENGPUMiner sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6' C-m
    sleep 5
    echo "---------------------------"
fi

if [ $num_available_gpus -eq 8 ]; then
    # If there are 8 GPUs, execute xengpuminer for all eight GPUs
    echo "Running XENGPUMiner for 8 GPUs..."
    tmux new-session -d -s miner-session
    sleep 5
    echo "---------------------------"
    
    # Split the screen
    tmux split-window -v
    sleep 5
    echo "---------------------------"

    # Running the python miner
    tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
    sleep 20
    echo "---------------------------"
    
    # Running the GPU miner for GPU 0, GPU 1, GPU 2, GPU 3, GPU 4, GPU 5, GPU 6, and GPU 7
    tmux send-keys -t 1 'cd XENGPUMiner sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6 & ./xengpuminer -d7' C-m
    sleep 5
    echo "---------------------------"
fi

if [ $num_available_gpus -eq 9 ]; then
    # If there are 9 GPUs, execute xengpuminer for all nine GPUs
    echo "Running XENGPUMiner for 9 GPUs..."
    tmux new-session -d -s miner-session
    sleep 5
    echo "---------------------------"
    
    # Split the screen
    tmux split-window -v
    sleep 5
    echo "---------------------------"

    # Running the python miner
    tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
    sleep 20
    echo "---------------------------"
    
    # Running the GPU miner for GPU 0, GPU 1, GPU 2, GPU 3, GPU 4, GPU 5, GPU 6, GPU 7, and GPU 8
    tmux send-keys -t 1 'cd XENGPUMiner sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6 & ./xengpuminer -d7 & ./xengpuminer -d8' C-m
    sleep 5
    echo "---------------------------"
fi

if [ $num_available_gpus -eq 10 ]; then
    # If there are 10 GPUs, execute xengpuminer for all ten GPUs
    echo "Running XENGPUMiner for 10 GPUs..."
    tmux new-session -d -s miner-session
    sleep 5
    echo "---------------------------"
    
    # Split the screen
    tmux split-window -v
    sleep 5
    echo "---------------------------"

    # Running the python miner
    tmux send-keys -t 0 'cd XENGPUMiner && python3 miner.py --gpu=true' C-m
    sleep 20
    echo "---------------------------"
    
    # Running the GPU miner for GPU 0, GPU 1, GPU 2, GPU 3, GPU 4, GPU 5, GPU 6, GPU 7, GPU 8, and GPU 9
    tmux send-keys -t 1 'cd XENGPUMiner sudo chmod +x xengpuminer && ./xengpuminer -d0 & ./xengpuminer -d1 & ./xengpuminer -d2 & ./xengpuminer -d3 & ./xengpuminer -d4 & ./xengpuminer -d5 & ./xengpuminer -d6 & ./xengpuminer -d7 & ./xengpuminer -d8 & ./xengpuminer -d9' C-m
    sleep 5
    echo "---------------------------"
fi
