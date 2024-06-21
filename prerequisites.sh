#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
RESET='\033[0m'

options=(
    "Node.js and npm"
    "Angular CLI"
    "Ionic CLI"
    "Python 3"
    "Ruby and Rails"
    "OpenJDK 11"
    "Go"
    "Rust"
    "Docker"
    "kubectl"
    "PHP"
    "Composer"
    "All Components"
)

install_commands=(
    "sudo apt-get install -y nodejs npm"
    "npm install -g @angular/cli"
    "npm install -g @ionic/cli"
    "sudo apt-get install -y python3"
    "sudo apt-get install -y ruby-full && gem install rails"
    "sudo apt-get install -y openjdk-11-jdk"
    "sudo apt-get install -y golang-go"
    "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
    "sudo apt-get install -y docker.io"
    "sudo apt-get install -y kubectl"
    "sudo apt-get install -y php"
    "sudo apt-get install -y composer"    
)

selected=()

echo -e "${CYAN}===================================${RESET}"
echo -e "${YELLOW}     Developer Tools Installer    ${RESET}"
echo -e "${CYAN}===================================${RESET}"

echo -e "\n${BLUE}Available options:${RESET}"
for i in "${!options[@]}"; do
    echo -e "${GREEN}$((i+1)).${RESET} ${options[i]}"
done

echo -e "\n${YELLOW}Enter the numbers of the options you want to install, separated by commas:${RESET}"
read -p "> " choices

IFS=',' read -ra choice_array <<< "$choices"
for choice in "${choice_array[@]}"; do
    choice=$(echo "$choice" | tr -d ' ')
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le ${#options[@]} ]; then
        if [ "$choice" -eq ${#options[@]} ]; then
            for i in "${!options[@]}"; do
                selected[$i]=1
            done
            break
        else
            selected[$((choice-1))]=1
        fi
    else
        echo -e "${RED}Error: Invalid option '$choice'. Please enter valid option numbers.${RESET}"
        exit 1
    fi
done

echo -e "\n${BLUE}You selected:${RESET}"
for i in "${!selected[@]}"; do
    if [[ "${selected[i]}" ]]; then
        echo -e "${GREEN}✓${RESET} ${options[i]}"
    fi
done

echo -e "\n${YELLOW}Proceed with installation? (y/n)${RESET}"
read -p "> " confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    echo -e "\n${CYAN}===================================${RESET}"
    echo -e "${YELLOW}        Installing Options        ${RESET}"
    echo -e "${CYAN}===================================${RESET}\n"
    for i in "${!selected[@]}"; do
        if [[ "${selected[i]}" ]] && [ "$i" -ne $((${#options[@]}-1)) ]; then
            echo -e "${MAGENTA}Installing ${options[i]}...${RESET}"
            eval "${install_commands[i]}"
            echo -e "${GREEN}✓ ${options[i]} installed.${RESET}"
            echo
        fi
    done
    echo -e "${CYAN}===================================${RESET}"
    echo -e "${GREEN}      Installation Complete!      ${RESET}"
    echo -e "${CYAN}===================================${RESET}"

    echo -e "\n${YELLOW}Would you like to create an alias for this script? (y/n)${RESET}"
read -p "> " create_alias
if [[ $create_alias == [yY] || $create_alias == [yY][eE][sS] ]]; then
    echo -e "\n${YELLOW}Enter the alias name you'd like to use:${RESET}"
    read -p "> " alias_name

    if [[ -f ~/.zshrc ]]; then
        config_file=~/.zshrc
    elif [[ -f ~/.bashrc ]]; then
        config_file=~/.bashrc
    else
        echo -e "${RED}Error: Neither .zshrc nor .bashrc found. Alias not created.${RESET}"
        exit 1
    fi

    script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
    echo "alias $alias_name='bash $script_dir/pkgManager.sh'" >> "$config_file"
    echo -e "${GREEN}Alias '$alias_name' has been added to $config_file${RESET}"
    echo -e "${YELLOW}Please restart your terminal or run 'source $config_file' to use the new alias.${RESET}"
fi
else
    echo -e "\n${RED}Installation cancelled.${RESET}"
fi
