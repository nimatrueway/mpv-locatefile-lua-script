--// Extract file dir from url
function GetFileName(url)
  return url:match("^.+/([^/]+)$")
end
function GetDirectory(url)
  return url:match("^(.+)/[^/]+$")
end

-- for ubuntu
file_browser_linux_cmd = "nohup nautilus --select '$path' &"
-- for macos
file_browser_macos_cmd = "open -a Finder '$path'"
-- for windows
file_browser_windows_cmd = "explorer /select,\"$path\""

--// check if macos
function is_macos()
  local homedir = os.getenv("HOME")
  if homedir ~= nil and homedir.sub(1, 6) == "/Users" then
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

--// handle "locate-current-file" function triggered by a key in "input.conf"
mp.register_script_message("locate-current-file", function()
  file_browser_cmd = file_browser_linux_cmd
  local filepath = mp.get_property("path")
  if is_windows() then
    file_browser_cmd = file_browser_windows_cmd
    filepath = filepath:gsub("/", "\\")
  elseif is_macos() then
    file_browser_cmd = file_browser_macos_cmd
  else
    file_browser_cmd = file_browser_linux_cmd
  end	
  if filepath ~= nil then
    cmd = file_browser_cmd:gsub("$path", filepath)
    mp.osd_message('Browse ' .. filepath)
    os.execute(cmd)
  end
end)
