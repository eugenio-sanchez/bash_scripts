# **Eugenio's Linux Utility Commands**

This collection of Bash scripts installs custom terminal commands that help set up various development environments on your computer. The commands are installed as executable scripts in **/usr/local/bin**. Each command is defined in a Bash script, and its name is added to `commands.txt`. The `build-command.sh` script then reads from `commands.txt` to create and install these commands on the system.

### Commands:
- **create-python-venv:**  
  This command sets up a Python virtual environment, creates a `main.py` file, and automatically opens Visual Studio Code (if installed).

- **create-jupyter-venv:**  
  This command sets up a virtual environment with Jupyter Notebook and installs popular data science libraries
