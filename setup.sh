#!/bin/bash

# Fetch the OS name 
os_type="$(uname -s)"

# print the OS name 
echo "Here is Your system :- $os_type "

# Check, system has the virtual env 
venv_installed="$(python3 -c 'import venv; print("installed")')"
echo "Wow, You have already installed virtual-env: $venv_installed"

# Install virtual env if it is not installed

if [[ -z "$venv_installed" ]]; then
    # for mac OS
    if [[ "$os_type" == "Darwin" ]]; then
        python3 -m pip install --user venv
        echo "Installation has been done on your $os_type"
    # for Linux OS
    elif [[ "$os_type" == "Linux" ]]; then
        # Linux
        sudo apt-get update
        sudo apt-get install python3-venv -y
        echo "Installation has been done on your $os_type"
    else
        # Other than Linux and window
        echo "Unsupported operating system: $os_type"
        exit 1
    fi
fi

# You can select the environment which you have already created or you can create
echo -n "Do you want to use an existing environment? [y/n]: "

read use_existing_env

if [[ "$use_existing_env" == "y" ]]; then
    # User can enter the name of the existing environment
    echo -n "Enter the name of the existing environment: "
    read existing_env_name
else
    # User can enter the name for a new environment
    echo -n "Enter the name for your new environment: "
    read new_env_name
    

    python3 -m venv $new_env_name
    echo "New environment '$new_env_name' has been created"
    
    existing_env_name=$new_env_name
fi

# command to run the activate the Virtual ENV
echo "Running the source command"
source $existing_env_name/bin/activate
echo "Activation has been done in your $os_type"

# You can install required package using requirements.txt

echo "Installing the package using requirements.txt file"
pip install -r requirements.txt
echo "Packages have been installed from requirements.txt"
