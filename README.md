# Package_Manager
This project provides two scripts to setup and manage development environments: a Developer Tools Installer and a Package Manager.

# Features
## Developer Tools Installer (prerequisites.sh)

- Interactive CLI for selecting and installing common development tools
- Supports installation of multiple tools in one go
- Option to install all available tools at once
- Ability to create an alias for easy future access

## Package Manager (pkgManager.sh)

- Quick setup for various frameworks, libraries, and tools
- User defined packages can be installed
- Supports multiple package installations in a single command
- Prompts for project-specific details like app name , project name and more
- Handles different setup requirements for various technologies

# Usage

1. Go to the cloned directory
2. Make the script executable
   ```bash
   chmod +x prerequisites.sh
   ```
3. Run the script
   ```bash
   ./prerequisites.sh
   ```
4. Install required environments
5. Set a keyword as an alias to run the script globally
6. Check for the keywords and commands in commands.txt
7. To add custom commands , add the keyword and command in the arrays declared in pkgManager.sh
8. For Shells other than bash and zsh , add shell location inside the pkgManager.sh
