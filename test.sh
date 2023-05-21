#! /bin/bash

# Turn off Network Time Protocol (NTP)
sudo systemsetup -setusingnetworktime off

# Set your own date (format = [mm][dd][HH][MM][yy])
Sudo date 0201060023

# Launch the application (Drag it into terminal to see full pathname)
Open /Applications/Parallels\ Desktop.app

# Wait for 10 seconds to allow app to fully startup
sleep 10

# Turn on NTP
Sudo systemsetup -setusingnetworktime on
