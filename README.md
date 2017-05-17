# Scripts and app to help create and organize commands in Apple Remote Desktop

#### This script assume a couple of things:
* you have Apple Remote Installed on the local machine
* you run this script in the user account that uses Apple Remote Desktop
* for clarity and to avoid name collisions, all folders and commands you create should have unique names otherwise you can receive errors when trying to delete or move folders or commands
* don't change anything in ARDplist.rb unless you know what you're doing
* it assumes you already have a file at ~/Library/Containers/com.apple.RemoteDesktop/Data/Library/Application Support/Remote Desktop/Presets/UnixCommandTask.plist, if you don’t open Apple Remote Desktop, click on “Unix” and save anything as your first command .. this auto generates the UnixCommandTask.plist file
* Make sure your script to execute the commands and the ARDplist.rb are in the same directory
* Make sure at the top of your file you type: require './ARDplist' ... see ARDplist_usage for examples

#### Usage:
After require ARDplist.rb in your ruby file, you can run the command below to see all your options.
```ruby
puts ARD.list_options
```
This will return:
> - create_command
> - create_folder
> - create_spacer
> - delete_command
> - delete_folder
> - folder_index
> - list_folders
> - move_folder
> - options
> - rename_command
> - rename_folder



#### Examples: ..

#print exisintg commands and folders
```ruby 
puts.ARD.list_folders
```
> returns any existing single commands or folders in ARD

---
#get the physical location of a folder
``` ruby
puts ARD.folder_index("folder1")
```
> returns the phyiscal position of folder "folder1" as an interger
---


#move position of exisiting folder. arguments are (original_position, new_position)
```ruby
ARD.move_folder(1, 0)
```

---

#rename an exisiting folder. arguments are (oldname, newname)
```ruby
ARD.rename_folder("folder1", "folder0")
```
---

#rename an existing command. arguments (folder_name, orignialcommandname, newcommandname)
 ```ruby
 ARD.rename_command("folder0", "command2", "command1")
 ```
 ---

 #creates a visual space by using ----, arguments is physical location you want to create the spacer
 ```ruby
 ARD.create_spacer(1)
 ```
 ---

#rename an exisiting folder. aguments are (oldname, newname)
```ruby
ARD.rename_folder("folder1", "folder0")
```
---
#Rename a command, arguments are ("folder_name", "orignialcommandname", "newcommandname")
```ruby
ARD.rename_command("Admin Commands", "list of users", "all users")
```
---
#Delete a command, arguments ("folder_name", "command_name")
```ruby
ARD.delete_command("folder2", "command1")
```
---

#delete an exisiting folder, areguments are ("foldername")
```ruby
ARD.delete_folder("folder2")
```










