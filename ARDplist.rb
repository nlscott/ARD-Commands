#!/usr/bin/ruby

require 'cfpropertylist'
require 'etc'

module ARD

	CURRENTUSER=Etc.getlogin
	PLISTFILE="/Users/#{CURRENTUSER}/Library/Containers/com.apple.RemoteDesktop/Data/Library/Application Support/Remote Desktop/Presets/UnixCommandTask.plist"
	@plist = CFPropertyList::List.new(:file => "#{PLISTFILE}")
	@results = CFPropertyList.native_types(@plist.value)

	class Command
		attr_reader :foldername, :commandname, :outputmode, :script, :user, :userselect

		def initialize(foldername, commandname, outputmode, script, user, userselect)
			@foldername =	foldername
			@commandname =	commandname
			@outputmode = outputmode
			@script = script
			@user = user
			@userselect = userselect
		end
	end

	#========================================================
	# Methods

	#print folder names
	def self.list_folders
		folders=[]
		for x in @results
			 folders.push(x['name'])
		end
		return folders
	end

	#find index of folder
	def self.folder_index(folder)
		indexnumber=nil
		for x in @results
			if x['name'] == folder
				indexnumber = @results.index(x)
			end
		end
	 	if indexnumber.nil?
			return "Folder does not exist"
		else
			return indexnumber
		end
	end

	#add new folder with command
	def self.create_folder(command)
		data3=Hash.new
		data3['name']="#{command.foldername}"
		data3['state']=[data4=Hash.new]
		data3['state'][0]={"name" => "#{command.commandname}", 'state' => Hash.new}
		data3['state'][0]['state']['outputMode']= command.outputmode
		data3['state'][0]['state']['script']= "#{command.script}"
		data3['state'][0]['state']['user']= "#{command.user}"
		data3['state'][0]['state']['userSelect']= command.userselect
		@results.push(data3)
		@plist.value = CFPropertyList.guess(@results)
		@plist.save("#{PLISTFILE}", CFPropertyList::List::FORMAT_XML)
	end

	def self.create_command(command)
		indexnumber=folder_index(command.foldername).to_i
		data = Hash.new
		data2 = Hash.new
		data2["outputMode"]= command.outputmode
		data2["script"]= "#{command.script}"
		data2["user"]= "#{command.user}"
		data2["userSelect"]= command.userselect
		data['name'] = "#{command.commandname}"
		data['state'] = data2
		@results[indexnumber]['state'].push(data)
		@plist.value = CFPropertyList.guess(@results)
		@plist.save("#{PLISTFILE}", CFPropertyList::List::FORMAT_XML)
	end

	#create a spacer
	def self.create_spacer(position)
		position=position.to_i
		data3=Hash.new
		data3['name']="- - - - - - - - - - -"
		@results.push(data3)
		indexnumber = folder_index("- - - - - - - - - - -")
		puts "index is #{indexnumber}"
		@results.insert(position, @results.delete_at(indexnumber.to_i))
		@plist.value = CFPropertyList.guess(@results)
		@plist.save("#{PLISTFILE}", CFPropertyList::List::FORMAT_XML)
	end

	#move an exisiting folders poistion
	def self.move_folder(originialposition, newposition)
		newposition=newposition.to_i
		originialposition=originialposition.to_i
		@results.insert(newposition, @results.delete_at(originialposition))
		@plist.value = CFPropertyList.guess(@results)
		@plist.save("#{PLISTFILE}", CFPropertyList::List::FORMAT_XML)
	end

	#delete an existing folder
	def self.delete_folder(folder)
		indexnumber = folder_index("#{folder}")
		indexnumber = indexnumber.to_i
		@results.delete(@results[indexnumber])
		@plist.value = CFPropertyList.guess(@results)
		@plist.save("#{PLISTFILE}", CFPropertyList::List::FORMAT_XML)
	end

	#rename an exisiting folder
	def self.rename_folder(oldname, newname)
		indexnumber = folder_index("#{oldname}")
		indexnumber = indexnumber.to_i
		@results[indexnumber]['name'] = newname
		@plist.value = CFPropertyList.guess(@results)
		@plist.save("#{PLISTFILE}", CFPropertyList::List::FORMAT_XML)
	end

	#delete an exisiting command
	def self.delete_command(folder_name, command_name)
		indexnumber = folder_index("#{folder_name}")
		indexnumber = indexnumber.to_i

		command_indexnumber=nil
		for x in @results[indexnumber]['state']
			if x['name'] == "#{command_name}"
				command_indexnumber = @results[indexnumber]['state'].index(x)
			end
		end

		@results[indexnumber]['state'].delete(@results[indexnumber]['state'][command_indexnumber.to_i])
		@plist.value = CFPropertyList.guess(@results)
		@plist.save("#{PLISTFILE}", CFPropertyList::List::FORMAT_XML)
	end

	#rename an exisiting command
	def self.rename_command(folder_name, orignialcommandname, newcommandname)
		indexnumber = folder_index("#{folder_name}")
		indexnumber = indexnumber.to_i
		
		command_indexnumber=nil
		for x in @results[indexnumber]['state']
			if x['name'] == "#{orignialcommandname}"
				command_indexnumber = @results[indexnumber]['state'].index(x)
			end
		end		

		@results[indexnumber]['state'][command_indexnumber]['name'] = "#{newcommandname}"
		@plist.value = CFPropertyList.guess(@results)
		@plist.save("#{PLISTFILE}", CFPropertyList::List::FORMAT_XML)
	end

	def self.options
		puts ARD.methods(false).sort
	end

	def self.move_command(command, move_to_folder)
		@results[ARD.folder_index(move_to_folder)]["state"] << @results[ARD.folder_index(command)]
		@plist.value = CFPropertyList.guess(@results)
		@plist.save("#{PLISTFILE}", CFPropertyList::List::FORMAT_XML)
		ARD.delete_folder(command)
	end

	def self.create_empty_folder(new_folder_name)
		indexnumber = @results.count
		indexnumber = indexnumber.to_i
		data3=Hash.new
		data3['name']="#{new_folder_name}"
		@results.push(data3)
		state = Array.new
		@results[indexnumber]["state"] = state
		@plist.value = CFPropertyList.guess(@results)
		@plist.save("#{PLISTFILE}", CFPropertyList::List::FORMAT_XML)
	end

end


