property extension_list : {"torrent", "TORRENT"}

on adding folder items to this_folder after receiving these_items
	try
		repeat with i from 1 to number of items in these_items
			
			set this_item to item i of these_items
			
			set the item_info to the info for this_item
			if (the name extension of the item_info is in the extension_list) then
				
				set the folder_series to "/Users/Ypion/Dropbox/_autoload_torrent/series"
				set the folder_movies to "/Users/Ypion/Dropbox/_autoload_torrent/movies"
				set the folder_other to "/Users/Ypion/Dropbox/_autoload_torrent/other"
				
				set ss_tor_choice to {choose from list {"Сериал", "Фильм", "Другое"} with title "Куда качать торрент" with prompt "А выбери ка че за на?))" OK button name "Океюшки" cancel button name "Взад-назад" default items {"Monday"}}
				if item 1 of ss_tor_choice is {"Сериал"} then
					tell application "Finder"
						move file this_item to "Macintosh HD:Users:Ypion:Dropbox:_autoload_torrent:series:" with replacing
					end tell
					--display notification "Торрент-файл" & (name of this_item) & "будет закачан в сериалы"
					--delay 1
				else if item 1 of ss_tor_choice is {"Фильм"} then
					tell application "Finder"
						move file this_item to "Macintosh HD:Users:Ypion:Dropbox:_autoload_torrent:movies:" with replacing
					end tell
					--display notification "Торрент-файл" & (name of this_item) & "будет закачан в фильмы"
					--delay 1
				else if item 1 of ss_tor_choice is {"Другое"} then
					tell application "Finder"
						move file this_item to "Macintosh HD:Users:Ypion:Dropbox:_autoload_torrent:other:" with replacing
					end tell
					--display notification "Торрент-файл" & (name of this_item) & "будет закачан в стандартную директорию"
					--delay 1
				end if
			end if
		end repeat
		
	on error error_message number error_number
		if the error_number is not -128 then
			tell application "Finder"
				activate
				display dialog error_message buttons {"Cancel"} default button 1 giving up after 120
			end tell
		end if
	end try
end adding folder items to

on resolve_conflicts(this_item, target_folder)
	tell application "Finder"
		set the file_name to the name of this_item
		if (exists document file file_name of target_folder) then
			set file_extension to the name extension of this_item
			if the file_extension is "" then
				set the trimmed_name to the file_name
			else
				set the trimmed_name to text 1 thru -((length of file_extension) + 2) of the file_name
			end if
			set the name_increment to 1
			repeat
				set the new_name to (the trimmed_name & "." & (name_increment as string) & "." & file_extension) as string
				if not (exists document file new_name of the target_folder) then
					-- rename to conflicting file
					set the name of document file file_name of the target_folder to the new_name
					exit repeat
				else
					set the name_increment to the name_increment + 1
				end if
			end repeat
		end if
	end tell
end resolve_conflicts
