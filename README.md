# bck.sh

A simple **bash script** to create compressed backups (`.tar.bz2`) from a source directory into a destination directory.

## Usage

```bash
./bck.sh <backup_name> <source_path> <destination_path>
```

### Example

```bash
./bck.sh project /home/user/project /mnt/backups
```

This will generate a file named:

```
project-YYYY-MM-DD-HH:MM:SS.tar.bz2
```

inside the `/mnt/backups` directory.

## Requirements

- Bash  
- `tar` package (the script checks if it is installed and offers to install it if missing)  
- Sufficient permissions to read the source folder and write into the destination folder  

## Features

- **Colored output** for better readability  
- **Interrupt handling** (`Ctrl+C`): the script exits with a message  
- **Exit trap**: shows a finished message when the script ends  
- **Argument validation**: requires exactly 3 arguments  
- **Path validation**: only accepts absolute paths  
- **Path normalization**: removes trailing `/` if present  
- **Root check**: prints a warning if not executed as root  
- **Automatic `tar` installation**: if not installed, the script prompts the user to install it using `apt`  

## Help panel

If arguments are missing or invalid, the script shows:

```
You must provide bck name, the source path and the destination path
    ./bck.sh /path/source /path/destination
Only full paths
```

## Notes

- The first argument (`backup_name`) is a **prefix**. The script appends the current date and time plus the `.tar.bz2` extension.  
- Only **absolute paths** (starting with `/`) are allowed.  
- The script does not check for available disk space. The user must ensure the destination has enough free space.  
