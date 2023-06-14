#!/bin/bash

# Store the absolute path of the script in a variable
pwd_script=$(pwd)/pipewire.sh
clear

# Display script information and prompt for user input
echo "This script will switch your audio from PulseAudio to Pipewire"
echo "For Ubuntu 22.04 based distros"
echo "Please grant root access when prompted"
sleep 2

read -p "Install Pipewire Now? (Y/N): " user_input

# Convert user input to lowercase for case-insensitive comparison
user_input=$(echo "$user_input" | tr '[:upper:]' '[:lower:]')

if [ "$user_input" == "y" ]; then
    clear

    # Update the package repository
    echo "Checking for updates (REPO)"
    sudo apt update -y &> /dev/null
    sleep 1

    # Install required packages for Pipewire
    echo "Installing packages"
    sudo apt install pipewire-audio-client-libraries libspa-0.2-bluetooth libspa-0.2-jack wireplumber -y &> /dev/null
    sleep 1

    # Remove PulseAudio Bluetooth module
    echo "Removing PulseAudio Bluetooth module"
    sudo apt autoremove --purge pulseaudio-module-bluetooth -y &> /dev/null
    sleep 1

    # Set permissions in Systemctl for the WirePlumber service
    echo "Setting Permissions in Systemctl"
    systemctl --user --now enable wireplumber.service &> /dev/null
    sleep 1

    # Prompt user to reboot the system
    echo "All done! Please reboot"
    sleep 3

elif [ "$user_input" == "n" ]; then
    clear
    echo "OK, aborting"
    exit

else
    clear
    echo "Please enter a valid input"
    echo "Script will restart in 2 seconds"
    sleep 2
    bash "$pwd_script"
fi

# Clear the terminal screen and display author information
clear
echo "Created by Shankar Vallabhan A (v3kt0r-87)"
echo "This script is released under the BSD 3-Clause license"
echo "GitHub: https://github.com/v3kt0r-87"

