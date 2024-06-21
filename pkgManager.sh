#!/bin/bash

declare -A pkg_commands

pkg_commands=(
    [node]="npm init"
    [cra]="npx create-react-app"
    [react]="npm create vite@latest appname -- --template react"
    [reactnative]="npx react-native init"
    [astro]="npm create astro@latest"
    [angular]="ng new"
    [express]="npm init && npm install express --save"
    [vue]="npm init vue@latest"
    [nextjs]="npx create-next-app"
    [nuxtjs]="npx nuxi init"
    [nestjs]="npm i -g @nestjs/cli && nest new"
    [django]="python -m django startproject"
    [flask]="python -m venv venv && pip install Flask"
    [fastapi]="python -m venv venv && pip install fastapi"
    [rails]="rails new"
    [spring]="spring init"
    [dotnet]="dotnet new"
    [golang]="go mod init"
    [rust]="cargo new"
    [svelte]="npm create vite@latest appname -- --template svelte"
    [gatsby]="npm init gatsby"
    [electronjs]="npm init electron-app"
    [ionic]="ionic start"
    [sass]="npm install -g sass"
    [bootstrap]="npm install bootstrap"
    [tailwind]="npm install -D tailwindcss"
    [bulma]="npm install bulma"
    [foundation]="npm install foundation-sites"
    [materialize]="npm install materialize-css"
    [semantic-ui]="npm install semantic-ui"
    [stylus]="npm install stylus"
    [less]="npm install less"
    [postcss]="npm install postcss"
    [purgecss]="npm install @fullhuman/postcss-purgecss"
    [parcelcss]="npm install parcel-bundler"
    [stylelint]="npm install stylelint"
    [webpack]="npm install --save-dev webpack webpack-cli"
    [babel]="npm install --save-dev @babel/core @babel/cli @babel/preset-env"
    [eslint]="npm install --save-dev eslint"
    [prettier]="npm install --save-dev prettier"
    [jest]="npm install --save-dev jest"
    [cypress]="npm install cypress --save-dev"
    [storybook]="npx sb init"
    [typescript]="npm install --save-dev typescript"
    [graphql]="npm install graphql"
    [apollo]="npm install @apollo/client"
    [redux]="npm install redux react-redux"
    [mobx]="npm install mobx mobx-react"
    [rxjs]="npm install rxjs"
    [socketio]="npm install socket.io"
    [threejs]="npm install three"
    [d3]="npm install d3"
    [chartjs]="npm install chart.js"
    [leaflet]="npm install leaflet"
    [jquery]="npm install jquery"
    [lodash]="npm install lodash"
    [moment]="npm install moment"
    [mongoose]="npm install mongoose"
    [mongodb]="npm install mongodb"
    [mysql]="npm install mysql"
    [postgres]="npm install pg"
    [sqlite]="npm install sqlite3"
    [redis]="npm install redis"
    [elasticsearch]="npm install elasticsearch"
    [rabbitmq]="npm install amqplib"
    [kafka]="npm install kafka-node"
    [firebase]="npm install firebase"
    [aws-sdk]="npm install aws-sdk"
    [gcloud]="npm install @google-cloud/storage"
    [docker]="docker run"
    [kubernetes]="kubectl create"
    [nginx]="npm install nginx"
    [apache]="npm install apache"
    [nest]="npm i -g @nestjs/cli && nest new"
    [laravel]="composer create-project laravel/laravel"
)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

echo -e "\n${YELLOW}Enter the keywords for the commands you want to run, separated by spaces:${RESET}"
read -p "> " input

IFS=' ' read -ra selected <<< "$input"

echo -e "${BLUE}You selected:${RESET}"
for item in "${selected[@]}"; do
    if [[ -n "${pkg_commands[$item]}" ]]; then
        echo -e "${GREEN}✓${RESET} $item"
    else
        echo -e "${RED}✗${RESET} $item (Invalid keyword)"
    fi
done

echo -e "${YELLOW}Do you want to proceed? (y/n)${RESET}"
read -p "> " confirm

if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    for item in "${selected[@]}"; do
        if [[ -n "${pkg_commands[$item]}" ]]; then
            command="${pkg_commands[$item]}"
            
            if [[ $command == *"appname"* ]]; then
                echo -e "${YELLOW}Enter app name for $item: ${RESET}"
                read -p "" app_name
                command=${command//appname/$app_name}
            fi
            if [[ $command == *"new"* || $command == *"init"* || $command == *"create"* ]]; then
                echo -e "${YELLOW}Enter project name for $item: ${RESET}"
                read -p "" project_name
                command="$command $project_name"
            fi
            if [[ $item == "golang" ]]; then
                echo -e "${YELLOW}Enter module name for $item: ${RESET}"
                read -p "" module_name
                command="$command $module_name"
            fi
            if [[ $item == "docker" ]]; then
                echo -e "${YELLOW}Enter image name for $item: ${RESET}"
                read -p "" image_name
                command="$command $image_name"
            fi
            if [[ $item == "kubernetes" ]]; then
                echo -e "${YELLOW}Enter resource type for $item: ${RESET}"
                read -p "" resource_type
                command="$command $resource_type"
            fi

            echo -e "\n${BLUE}Running command for $item:${RESET}"
            echo -e "${GREEN}$command${RESET}"
            eval "$command"
        fi
    done
    echo -e "\n${GREEN}All selected commands have been executed.${RESET}"
else
    echo -e "\n${RED}Operation cancelled.${RESET}"
fi