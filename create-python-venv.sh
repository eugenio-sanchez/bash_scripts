#!/bin/bash

# Define the Python version you want
PYTHON_VERSION="3.8"  # Change this if you need a different version

# Check if Python is installed
if command -v python3 &>/dev/null; then
    echo "Python is already installed."
else
    echo "Python not found. Installing Python $PYTHON_VERSION..."
    
    # Update package list and install Python
    sudo apt-get update
    sudo apt-get install -y python${PYTHON_VERSION} python${PYTHON_VERSION}-venv python${PYTHON_VERSION}-pip
fi

# Create a virtual environment
VENV_DIR="venv"
python3 -m venv ${VENV_DIR}

# Activate the virtual environment
source ${VENV_DIR}/bin/activate

# Upgrade pip in the virtual environment
pip install --upgrade pip

touch main.py

echo "venv/" >> .gitignore

echo "Setup complete. Virtual environment '${VENV_DIR}' created and basic packages installed."

if command -v code &> /dev/null; then
	echo "Visual Studio Code is installed. Opening..."
	code .
else 
	echo "Visual Studio Code not installed." 
fi



