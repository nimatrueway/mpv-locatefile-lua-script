## mpv-locatefile <img src="https://cloud.githubusercontent.com/assets/8236909/9288343/8b64fb36-434a-11e5-980c-bd2cf67cb0a2.jpg" width="30">
#### mpv-locatefile is a tiny lua script for mpv to open current media file in OS file browser

###### Usage
* Copy `locatefile.lua` script to (linux/macos) `~/.config/mpv/scripts/bookmarker.lua` (win) `%APPDATA%\mpv\scripts\bookmarker.lua`.
* Open key configuration file at (linux/macos) `~/.config/mpv/input.conf` (win) `%APPDATA%\mpv\input.conf` and map your desired key to `locate-current-file` script_message, for example:
```    
Alt+o script_message locate-current-file
```

###### Bug reporting

Feel free to create an issue in github, but make sure you provide me with enough information in the description:

* Your operating system.
* Run `mpv` with `--msg-level='locatefile=debug'` and attach your console output to the issue.

###### Tested on Ubuntu, macOS 10.12+, Windows 10
