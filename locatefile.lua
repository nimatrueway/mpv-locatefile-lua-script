--// Extract file dir from url
function GetFileName(url)
  return url:match("^.+/([^/]+)$")
end
function GetDirectory(url)
  return url:match("^(.+)/[^/]+$")
end

-- for ubuntu
-- file_browser_linux_cmd = "xdg-open \"$dir\""
file_browser_linux_cmd = "dbus-send --print-reply --dest=org.freedesktop.FileManager1 /org/freedesktop/FileManager1 org.freedesktop.FileManager1.ShowItems array:string:\"file:$path\" string:\"\""
-- for macos
file_browser_macos_cmd_osascript_content = 'tell application "Finder"' .. '\n' .. 'set frontmost to true' .. '\n' .. 'reveal (POSIX file "$path")' .. '\n' .. 'end tell' .. '\n'
file_browser_macos_cmd = 'osascript "$osascript_file"'
-- for windows
file_browser_windows_cmd = "explorer /select,\"$path\""

--// check if macos
function is_macos()
  local homedir = os.getenv("HOME")
  if homedir ~= nil and string.sub(homedir,1,6) == "/Users" then
    return true
  else
    return false
  end
end

--// check if windows
function is_windows()
  local windir = os.getenv("windir")
  if windir~=nil then
    return true
  else
    return false
  end
end

--// create temporary script
function create_temp_file(content)
  local tmp_filename = os.tmpname()
  local tmp_file = io.open(tmp_filename, "wb")
  tmp_file:write(content)
  io.close(tmp_file)
  return tmp_filename
end

--// create temporary script
function GetDirectory(url)
  return url:match("^(.*)/[^/]+$")
end

--// handle "locate-current-file" function triggered by a key in "input.conf"
mp.register_script_message("locate-current-file", function()
  file_browser_cmd = file_browser_linux_cmd
  local filepath = mp.get_property("path")
  local filedir = GetDirectory(filepath)
  if is_windows() then
    filedir = mp.get_property("working-directory")
    file_browser_cmd = file_browser_windows_cmd
    filepath = filepath:gsub("/", "\\")
  elseif is_macos() then
    local content = file_browser_macos_cmd_osascript_content:gsub("$path", filepath)    
    file_browser_cmd = file_browser_macos_cmd:gsub("$osascript_file", create_temp_file(content))
  else
    file_browser_cmd = file_browser_linux_cmd
  end	
  if filepath ~= nil then
    cmd = file_browser_cmd:gsub("$path", filepath)
    cmd = cmd:gsub("$dir", filedir)
    mp.osd_message('Browse \n' .. filepath)
    os.execute(cmd)
  end
end)
