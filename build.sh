#!/bin/bash

# Get the current directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define the target directory (bin folder in the current directory)
TARGET_DIR="$SCRIPT_DIR/bin"

rm -r $TARGET_DIR
mkdir $TARGET_DIR

# Function to create symbolic links
create_symlink() {
    local source_file="$1"
    local target_file="$TARGET_DIR/$(basename "$source_file")"

    # Use the 'file' command to check if the source file is a Bash script
    if file "$source_file" | grep -q "Bourne-Again shell script"; then
        # Check if the target file already exists in the bin directory
        if [ -e "$target_file" ]; then
            echo "Symbolic link '$target_file' already exists. Skipping."
        else
            ln -s "$source_file" "$target_file"
            echo "Created symbolic link: $target_file -> $source_file"
        fi
    fi
}

# Loop over all files in the script directory and its subdirectories
find "$SCRIPT_DIR"/** -type f -print0 | while IFS= read -r -d $'\0' file; do
    create_symlink "$file"
done

chmod +x "$TARGET_DIR"/*
echo "Symbolic linking completed."
