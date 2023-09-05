
# Pushover backend for AstroPush.

### What's AstroPush?
[AstroPush](https://github.com/picciux/AstroPush.git) is a shell script based notify abstraction layer, targeted mainly at KStars/Ekos astrophotography systems on linux.

### How to use.
This is the AstroPush backend to route notifications through [Pushover](https://pushover.net) service. To use it, you need a Pushover **account**, and related auth tokens.

### Installation
1. Run `install.sh` script in this directory
2. Enter `/etc/astropush` folder.
3. Edit `backend.pushover.conf.sample` filling in needed data.
4. Rename `backend.pushover.conf.sample` to `backend.pushover.conf`
5. Edit AstroPush main config `push.conf` (you need sudo) and enable this backend following comments inside the file itself.
6. You're done! From a terminal, try: `> astropush os 'This is a test' info`. You should receive a notification on your Pushover connected device(s).

