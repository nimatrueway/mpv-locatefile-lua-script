## mpv-locatefile <img src="https://cloud.githubusercontent.com/assets/8236909/9288343/8b64fb36-434a-11e5-980c-bd2cf67cb0a2.jpg" width="30">
#### mpv-locatefile is a tiny lua script for mpv to open current media file in file browser

###### Usage
* Copy `locatefile.lua` script to `~/.config/mpv/scripts/locatefile.lua`
* Open key configuration file at `~/.config/mpv/input.conf` and map your desired keys to `locate-current-file` script message, for example:
```    
Alt+o script_message locate-current-file
```
###### Works on Ubuntu
* PRs for other OS are welcome.
