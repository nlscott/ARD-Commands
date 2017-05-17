#!/usr/bin/ruby

#this script must be in the same directory as ARDplist.rb
require './ARDplist'



#========================================================
#To create a new command as an example remove the keyworda =begin, and =end and then run the script

=begin
newcommand = ARD::Command.new(
  "folder1",#folder name
  "version", #command name
  true, #see output
  'sw_vers',#script
  "root", # user to run command as
  1) #select user to run command as radio button

ARD.create_folder(newcommand) #creates a new folder named "folder1" with a command named "version"
=end



#========================================================
#After you have a folder and command create,
#you can use the commands below to move positions,
#rename, or delete commands and folders

#list all ARD options
#puts ARD.options

#list all folders
#puts ARD.list_folders

#list folder index or physical position
#puts ARD.folder_index("folder1")

#move position of exisiting folder. arguments are (origiinal_position, new_position), expects numbers as arguments
#ARD.move_folder(1, 0)

#creates a visual space by using --------------, arguments are (index you want the spacer at)
#ARD.create_spacer(1)

#rename an exisiting folder. aguments are (oldname, newname)
#ARD.rename_folder("folder1", "folder0")

#Rename a command, arguments are ("folder_name", "orignialcommandname", "newcommandname")
#ARD.rename_command("folder0", "command1", "command4")

#Delete a command, arguments ("folder_name", "command_name")
#ARD.delete_command("folder2", "command1")

#delete an exisiting folder, areguments are ("foldername")
#ARD.delete_folder("folder2")
