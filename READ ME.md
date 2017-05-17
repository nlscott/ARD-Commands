Scripts and app to help create and organize commands in Apple Remote Desktop

This script assume a couple of things:
#1 - you have Apple Remote Installed on the local machine
#2 - you run this script in the user account that uses Apple Remote Desktop
#3 - for clarity and to avoid name collisions, all folders and commands you create should have unique names
#otherwise you can receive errors when trying to delete or move folders or commands
#4 - don't change anything in ARDplist.rb unless you know what you're doing
#5 - it assumes you already have a file at ~/Library/Containers/com.apple.RemoteDesktop/Data/Library/Application Support/Remote Desktop/Presets/UnixCommandTask.plist, if you don’t open Apple Remote Desktop, click on “Unix” and save anything as your first command .. this auto generates the UnixCommandTask.plist file

Usage:
- Make sure your script to execute the commands and the ARDplist.rb are in the same directory
- Make sure at the top of your file you type: require './ARDplist' ... see ARDplist_usage for examples