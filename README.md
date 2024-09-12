
# Filetree Script

`filetree.sh` is a Bash script that reads a tab-indented file representing a directory tree structure and creates the corresponding directory hierarchy under a specified target directory. Each line in the input file represents a directory name, and its indentation level is represented by tab characters.

The script checks the validity of the file format, ensures that directory names are valid for Linux systems, and creates the directories as specified.

## Features

- Reads a tab-indented file to determine the directory structure.
- Creates directories in a specified target location.
- Validates file format to ensure correct tab-based hierarchy.
- Validates that each directory name is a valid Linux filename.

## Prerequisites

- Bash shell (default in most Unix-like systems).
- Basic knowledge of using the terminal.
- A file with a valid tab-based directory tree structure.

## Usage

```bash
./filetree.sh -file <file_location> -tdir <target_directory>
```

### Arguments

- `-file <file_location>`: Specifies the location of the input file containing the directory tree structure.
- `-tdir <target_directory>`: Specifies the target directory where the directory structure will be created. If the directory does not exist, it will be created.

### Example

```bash
./filetree.sh -file filetree.txt -tdir /path/to/target_directory
```

This command will read the `filetree.txt` file, validate its structure, and create the directory hierarchy under `/path/to/target_directory`.

## Input File Format

The input file should be a tab-indented text file where:

- Each line represents a directory name.
- The number of leading tabs indicates the depth of the directory in the tree.
- Subdirectories must have one more tab than their parent directory.
- For example:

  ```plaintext
  folder/
      subfolder1/
      subfolder2/
          subsubfolder1/
  ```

## Validation

The script performs several validation checks:

1. **File and Directory Existence**: Checks if the input file exists and whether the target directory exists or needs to be created.
2. **File Format Validity**: Ensures that the file is formatted correctly, with indentation increasing by no more than one level at a time.
3. **Filename Validity**: Checks that directory names do not contain invalid characters (e.g., `/`) and are within the length limits for Linux filenames.

## Functions

### `is_valid_filename`

This function checks if a given string is a valid Linux filename. A valid filename:

- Does not contain a forward slash (`/`).
- Does not contain control characters.
- Is not empty.
- Does not exceed 255 characters in length.

## Error Handling

The script provides error messages for various conditions:

- Missing or incorrect arguments.
- Nonexistent input file or target directory.
- Invalid file format or directory names.

## Output

- If the directory structure is successfully created, the script prints messages indicating the creation of each directory.
- If any errors are encountered, the script outputs an appropriate error message and exits.

## Author

Written by User.

## License

This script is provided "as is" without warranty of any kind. You are free to use and modify it as needed.

## Contributing

If you wish to contribute to this project, feel free to open a pull request or raise an issue on GitHub.

## See Also

- [Bash Manual](https://www.gnu.org/software/bash/manual/)
- [mkdir Manual](https://man7.org/linux/man-pages/man1/mkdir.1.html)
- [sed Manual](https://www.gnu.org/software/sed/manual/sed.html)
- [awk Manual](https://www.gnu.org/software/gawk/manual/)
