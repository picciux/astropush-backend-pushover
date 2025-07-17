
# Pushover backend for AstroPush.

### What's AstroPush?
[AstroPush](https://github.com/picciux/astropush.git) is a shell script based notify abstraction layer, targeted mainly at KStars/Ekos astrophotography systems on linux.

### How to use.
This is the AstroPush backend to route notifications through [Pushover](https://pushover.net) service. To use it, you need a Pushover **account**, and related auth tokens.

### Installation
1. Run `install.sh` script in this directory
2. Enter `/etc/astropush` folder.
3. As an admin, you can edit `backend.pushover.conf` and `push.conf`, filling in needed data, to configure and enable the backend system-wide: this way, every user on the system will send AstroPush notifications using the system-wide credentials.
4. Alternatively, every user can override the system configuration creating and editing `push.conf` and `astropush-backend.pushover.conf` inside `~/.config` folder, thus using their own key and token.

You're done! From a terminal, try: `> astropush os 'This is a test' info`. You should receive a notification on your Pushover connected device(s).

