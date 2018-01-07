--// Extract file dir from url
function GetFileName(url)
  return url:match("^.+/([^/]+)$")
end
function GetDirectory(url)
  return url:match("^(.+)/[^/]+$")
end

file_browser_cmd = "nautilus '$path'"

--// handle "locate-current-file" function triggered by a key in "input.conf"
mp.register_script_message("locate-current-file", function()
	local filepath = mp.get_property("path")
	if filepath ~= nil then
		os.execute(file_browser_cmd:gsub("$path", filepath))
	end
end)
