#    Pushover backend for AstroPush, a simple push notification layer.
#    Copyright (C) 2022-2023  Matteo Piscitelli <matteo@matteopiscitelli.it>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# Pushover backend implementation

BACKEND_VERSION="1.1"

push_pushover() {
  # Check config file exists
  [ -f "$CONFIG_DIR/backend.pushover.conf" ] && source "$CONFIG_DIR/backend.pushover.conf"

  # override with user config
  [ -f "$USER_CONFIG_BE_PREFIX.pushover.conf" ] && source "$USER_CONFIG_BE_PREFIX.pushover.conf"

  # Check mandatory configs are valid
  [ "$APP_TOKEN" ] || { echo >&2 "Empty or not valid app token in config"; exit 1; }
  [ "$USER_KEY" ] ||  { echo >&2 "Empty or not valid user key in config"; exit 1; }

  me="$( hostname )"
  prio=0
  img=$1

  case "$1" in
	"os")
	title="OS@$me"
	;;

	"alignment")
	title="Alignment@$me"
	;;

	"capture")
	title="Capture@$me"
	;;

	"focus")
	title="Focus@$me"
	;;

	"kstars")
	title="KStars@$me"
	;;

	"guide")
	title="Guide@$me"
	;;

	"mount")
	title="Mount@$me"
	;;

	"scheduler")
	title="Scheduler@$me"
	;;

	*)
	title="Sconosciuto: $1@$me"
	img=''
	;;

  esac

  add_pars=''

  case $3 in
	#verbose
	1)
	prio=-2
	;;

	#info
	2)
	prio=-1
	;;

	#warn
	3)
	prio=0
	;;

	#error
	4)
	prio=1
	if [ "$emergency_on_error" = "yes" ]; then
		prio=2
		retry=60
		expire=3600
	fi
	;;
  esac

  curl -s \
		--form-string "token=$APP_TOKEN" \
		--form-string "user=$USER_KEY" \
		--form-string "title=$title" \
		--form-string "message=$2" \
		--form-string "priority=$prio" \
		--form-string "retry=$retry" \
		--form-string "expire=$expire" \
		https://api.pushover.net/1/messages.json > /dev/null

}
