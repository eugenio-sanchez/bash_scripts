#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Python is installed
if command_exists python3; then
    echo "Python is already installed."
else
    echo "Python is not installed. Installing Python..."
    sudo apt update
    sudo apt install -y python3 python3-pip
fi

# Create a virtual environment
VENV_DIR="jupyter_env"
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating virtual environment..."
    python3 -m venv "$VENV_DIR"
fi

# Activate the virtual environment
echo "Activating virtual environment..."
source "$VENV_DIR/bin/activate"

# Install Jupyter Notebook in the virtual environment
echo "Installing Jupyter Notebook in the virtual environment..."
pip install notebook pandas numpy matplotlib scikit-learn

# Start Jupyter Notebook
echo "Starting Jupyter Notebook..."
jupyter notebook

