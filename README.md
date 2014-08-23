iTunesCaster
============

**Lets you stream iTunes music playback from your Mac to your Chromecast**

*How it works:*

* Build or [download iTunesCaster.app](https://raw.githubusercontent.com/andsynchrony/iTunesCaster/master/Build/Debug/iTunesCaster.zip)
* Open iTunes application
* Open iTunesCaster
* Chrome browser will open a new tab that mirrors iTunes track and artist info
* Now you can stream this tab to any connected Chromecast
* Opened tab will react to play, pause button and track selection
* Control volume via the playback controls displayed in the tab

iTunesCaster is split into two parts:
* App connecting iTunes to Chrome (iTunesPoster & iTunesCaster.xcodeproj)
* HTML displaying iTunes information in Chrome (iTunesViewer)

*To do / Known issues*

* No video playback
* Streaming to Chromecast may be choppy depending on your wifi connection
* Volume controls from iTunes not added yet