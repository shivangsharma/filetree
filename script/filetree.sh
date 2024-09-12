#!/bin/bash

file_location=""
target_directory=""

# Read the arguments passed
while [[ "$#" -gt 0 ]]; do
	case $1 in 
		-file) file_location="$2"; shift;;
		-tdir) target_directory="$2"; shift;;
		*) echo "Unknown parameter passed: $1"; shift;;
	esac
	shift
done

# Check if file_location and target_directory variables are not empty
if [[ -z "$file_location" || -z "$target_directory" ]]; then
    echo "Usage: $0 -file <file_location> -tdir <directory>"
    exit 1
fi

# Check if the file exists
if [[ ! -f "$file_location" ]]; then
	echo "File does not exist: $file_location"
	exit 1
else
	echo "File $file_location found"
fi

# Check if target directory exists
if [[ ! -d "$target_directory" ]]; then
	echo "Target directory does not exist. Creating directory: $target_directory"
	mkdir -p "$target_directory"

	if [[ $? -eq 0 ]]; then
		echo "Directory created successfully: $target_directory"
	else
		echo "Failed to create directory: $target_loc"
		exit 1
	fi
else
	echo "Target directory exists: $target_directory"
fi

# If the file is tab-based, check if the file is valid
is_valid_filename() {
    local filename="$1"

    # Check if the filename is empty or contains '/'
    if [[ -z "$filename" || "$filename" == *"/"* ]]; then
        return 1  # Invalid filename
    fi

    # Check for control characters or invalid length (>255)
    if [[ "$filename" =~ [^[:print:]] ]] || [[ "${#filename}" -gt 255 ]]; then
        return 1  # Invalid filename
    fi

    return 0  # Valid filename
}

# Initialize the previous tab count
prev_tab_count=-1

# Array to track current directory structure
declare -a dir_stack=("$target_location")

while IFS= read -r line; do
    # Count leading tabs in the current line
    current_tab_count=$(echo "$line" | sed -E 's/^(\t*).*/\1/' | awk '{print length}')

    # Check if the current tab count is valid
    if (( current_tab_count > prev_tab_count + 1 )); then
        echo "Invalid file tree structure at line: '$line'"
        echo "Error: More than one tab increase compared to the previous line."
        exit 1
    fi

    # Extract the folder name from the line by removing leading tabs
    folder_name=$(echo "$line" | sed -E 's/^\t*//')

    # Check if the folder name is a valid Linux filename
    if ! is_valid_filename "$folder_name"; then
        echo "Invalid filename at line: '$line'"
        echo "Error: '$folder_name' is not a valid Linux filename."
        exit 1
    fi

    # Adjust the directory stack based on the current tab level
    if (( current_tab_count <= prev_tab_count )); then
        # Pop the stack to go up the hierarchy if needed
	dir_stack=("${dir_stack[@]:0:$(current_tab_count + 1)}")
    fi

    # Add the current folder to the stack
    dir_stack+=("$folder_name")

    # Create the full path
    full_path=$(IFS='/'; echo "${dir_stack[*]}")

    # Create the directory
    mkdir -p "$full_path"
    echo "Created directory: $full_path"

    # Update the previous tab count for the next iteration
    prev_tab_count=$current_tab_count

done < "$file_location"

echo "File tree structure and filenames are valid."
