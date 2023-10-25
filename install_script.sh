#!/bin/bash

# Get the current directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/bin"
echo $SCRIPT_DIR    

# Check if the directory is already in PATH
if grep -q "$SCRIPT_DIR" ~/.bashrc; then
  echo "The directory is already in the PATH."
else
  # Add the directory to PATH
  echo "export PATH=\"$PATH:$SCRIPT_DIR\"" >> ~/.bashrc
  echo "The directory has been added to the PATH. Restart your shell to apply changes."
fi
