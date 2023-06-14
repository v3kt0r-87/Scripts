#!/bin/bash

# Variables

script_dir=$(dirname "$0")

# Author information

author_info() {
  clear
  echo "Snapinator v1.0"
  echo "By Shankar Vallabhan A (v3kt0r-87)"
  echo "This script is released under the BSD-Clause 3 license"
}

# Install Flatpak

flatpak_install() {
  clear
  read -p "Do you want to install Flatpak? (Y/N): " user_input_2

  if [[ "$user_input_2" == "Y" || "$user_input_2" == "y" ]]; then
    clear
    echo "OK, let's install Flatpak :)"
    sleep 2

    sudo apt install flatpak gnome-software gnome-software-plugin-flatpak -y
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    clear
   sleep 1.25
   echo "All done :)"
   sleep 2

    author_info

  elif [[ "$user_input_2" == "N" || "$user_input_2" == "n" ]]; then
    clear
    echo "OK, not installing Flatpak"
    sleep 2
    author_info

  else
    echo "Wrong input, please try again"
    sleep 2
    flatpak_install
  fi
}

# Main script

clear
echo "Welcome to Snapinator"
sleep 2

clear
echo "This script will purge all Snap packages from your Ubuntu machine."
sleep 1
echo "You can also install Flatpak after purging Snap packages."

read -p "Continue? (Y/N): " user_input

if [[ "$user_input" == "Y" || "$user_input" == "y" ]]; then
  clear
  echo "OK, let's begin"
  sleep 1
  echo "Removing Snap Packages (purge)"
  sleep 1

  sudo snap remove --purge firefox
  sudo snap remove --purge gtk-common-themes
  sudo snap remove --purge gnome-3-38-2004
  sudo snap remove --purge bare
  sudo snap remove --purge snapd-desktop-integration
  sudo snap remove --purge snap-store
  sudo snap remove --purge core20
  sudo snap remove --purge snapd
  sudo apt autoremove --purge snapd
  sudo apt autoremove --purge -y
  sudo apt autoclean -y
  clear

  sleep 1.25
  echo "All done :)"
  sleep 2

  flatpak_install

elif [[ "$user_input" == "N" || "$user_input" == "n" ]]; then
  clear
  echo "OK, aborting"
  sleep 1
  exit

else
  clear
  echo "Please enter a valid input"
  echo "The script will now restart"
  sleep 2
  exec "$script_dir/snapinator.sh"
fi

