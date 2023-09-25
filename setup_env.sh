#!/bin/bash
# Setup script for Ansible environments.
# Created by: Anthony Pagan
# Created on: 2023-07-23
# Updated on: 2023-08-15

REQUIREMENTS_FILE="requirements.txt"
PYTHON_COMMAND="python3"
ANSIBLE_VENV_DIR=".ansible_venv"
ANSIBLE_VENV_NAME="Ansible"

# Check if the requirements file exists.
check_requirements_file() {
    if [ ! -f "$REQUIREMENTS_FILE" ]; then
        echo "$REQUIREMENTS_FILE does not exist."
        exit 1
    fi
}

# Check if Python is installed.
check_python_installed() {
    if ! command -v "$PYTHON_COMMAND" &>/dev/null; then
        echo "$PYTHON_COMMAND could not be found."
        exit 1
    fi
}

# Check if the python venv module is installed.
check_venv_module_installed() {
    if ! "$PYTHON_COMMAND" -c "import venv" &>/dev/null; then
        echo "The python venv module could not be found."
        exit 1
    fi
}

# Create a new virtual environment.
create_virtual_env() {
    # Check if the virtual environment directory exists.
    if [ -d "$ANSIBLE_VENV_DIR" ]; then
        echo "$ANSIBLE_VENV_DIR already exists."
        echo "Do you want to delete it? (y/n)"
        read -r delete_venv
        if [ "$delete_venv" = "y" ]; then
            echo "Deleting $ANSIBLE_VENV_DIR."
            rm -rf "$ANSIBLE_VENV_DIR"
            echo "Creating new virtual environment directory."
            "$PYTHON_COMMAND" -m venv "$ANSIBLE_VENV_DIR" --prompt "$ANSIBLE_VENV_NAME"
        fi
    else
        echo "Creating new virtual environment directory."
        "$PYTHON_COMMAND" -m venv "$ANSIBLE_VENV_DIR" --prompt "$ANSIBLE_VENV_NAME"
    fi
}

# Check if in a virtual environment. If yes, prompt to use the virtual environment or create a new one.
setup_virtual_env() {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "You are in a virtual environment."
        echo "Do you want to use this virtual environment? (y/n)"
        read -r use_virtual_env
        if [ "$use_virtual_env" = "y" ]; then
            echo "Using current virtual environment."
        else
            echo "Creating new virtual environment."
            create_virtual_env
        fi
    else
        echo "Creating new virtual environment."
        create_virtual_env
    fi
}

# Install Ansible.
install_ansible() {
    echo "Installing Ansible."
    "$PYTHON_COMMAND" -m pip install -r "$REQUIREMENTS_FILE"
}

# Ensure Ansible is installed.
check_ansible_installed() {
    if ! command -v ansible &>/dev/null; then
        echo "Ansible could not be found. Please check the installation."
        exit 1
    fi
}

# Print instructions.
print_instructions() {
    echo "
# Usage Instructions
  - To activate and use the virtual environment, run the following command:
    source $ANSIBLE_VENV_DIR/bin/activate
  
  - To deactivate the virtual environment, run the following command:
     deactivate
  
  - To run Ansible from within the virtual environment, run the following command:
    ansible-playbook -i inventory.yml playbook.yml
  
  - To run Ansible from outside the virtual environment, run the following command:
    $ANSIBLE_VENV_DIR/bin/ansible-playbook -i inventory.yml playbook.yml
"
}

# Main function.
main() {
    check_requirements_file
    check_python_installed
    check_venv_module_installed
    setup_virtual_env
    # Activate the virtual environment.
    source "$ANSIBLE_VENV_DIR/bin/activate"
    install_ansible
    check_ansible_installed
    print_instructions

    # Unset variables used in the script.
    unset ANSIBLE_VENV_DIR
    unset ANSIBLE_VENV_NAME
    unset PYTHON_COMMAND
    unset REQUIREMENTS_FILE
    unset delete_venv
    unset use_virtual_env

    exit 0
}

# Call the main function.
main
