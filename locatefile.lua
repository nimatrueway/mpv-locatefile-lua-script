utils = require 'mp.utils'

--// Extract file name from full path
function GetFileName(url)
  return url:match("^.+/([^/]+)$")
end

--// Extract directory from full path
function GetDirectory(url)
  return url:match("^(.+)/[^/]+$")
end

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
function get_directory(url)
  return url:match("^(.*)/[^/]+$")
end

------------------//-- locate functions --//--------------------

function locate_windows(filepath)  
  utils.subprocess_detached({args = {'explorer', '/select,' .. filepath:gsub('/', '\\')}})
end

function locate_macos(filepath)
  local file_browser_macos_cmd_osascript_content = 'tell application "Finder"' .. '\n' .. 'set frontmost to true' .. '\n' .. 'reveal (POSIX file "' .. filepath .. '")' .. '\n' .. 'end tell' .. '\n'
  local file_browser_macos_cmd = 'osascript ' .. create_temp_file(content)
  os.execute(file_browser_macos_cmd)
end

function locate_linux(filepath)
  dbus_cmd = 'dbus-send --print-reply --dest=org.freedesktop.FileManager1 /org/freedesktop/FileManager1 org.freedesktop.FileManager1.ShowItems array:string:"file:' .. filepath .. '" string:""'
  os.execute(dbus_cmd)
end

--// handle "locate-current-file" function triggered by a key in "input.conf"
mp.register_script_message("locate-current-file", function()
  local filepath = mp.get_property("path")
  if is_windows() then
    locate_windows(filepath)
  elseif is_macos() then
    locate_macos(filepath)
  else
    locate_linux(filepath)
  end
  mp.osd_message('Browse \n' .. filepath)
end)
