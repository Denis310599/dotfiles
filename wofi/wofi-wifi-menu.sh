#!/usr/bin/env bash

conf=~/.config/wofi-wifi-menu

# this prints a beautifully formatted list. bash was a mistake
nmcli -t d wifi rescan
LIST=$(nmcli --fields SSID,SECURITY,BARS device wifi list | sed '/^--/d' | sed 1d | sed -E "s/WPA*.?\S/~~/g" | sed "s/~~ ~~/~~/g;s/802\.1X//g;s/--/~~/g;s/  *~/~/g;s/~  */~/g;" | column -t -s '~')

# get current connection status
CONSTATE=$(nmcli dev show | grep STATE | sed -n "2,3p" | grep -E "30|100")
echo "$CONSTATE"
if [[ -n $CONSTATE ]]; then
	TOGGLE="Disable Networking  \n$LIST"
else
	TOGGLE="Enable Networking  "
fi

# display menu; store user choice
CHENTRY=$(echo -e "$TOGGLE" | uniq -u | wofi -d)
# store selected SSID
CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $1}')

if [ "$CHENTRY" = "" ]; then
    exit
elif [ "$CHENTRY" = "Enable Networking  " ]; then
	nmcli n on
	notify-send 'Wifi On'
elif [ "$CHENTRY" = "Disable Networking  " ]; then
	nmcli n off
	notify-send 'Wifi Off'
else
    # get list of known connections
    KNOWNCON=$(nmcli connection show)
	
	# If the connection is already in use, then this will still be able to get the SSID
	if [ "$CHSSID" = "*" ]; then
		CHSSID=$(echo "$CHENTRY" | sed  's/\s\{2,\}/\|/g' | awk -F "|" '{print $3}')
	fi

	# Parses the list of preconfigured connections to see if it already contains the chosen SSID. This speeds up the connection process
	if [[ -n $(echo "$KNOWNCON" | grep "$CHSSID") ]]; then
		if nmcli con up "$CHSSID"; then
			notify-send 'Connected!'
		else
			notify-send 'Connection failed'
		fi


	else
		if [[ "$CHENTRY" =~ "" ]]; then
			WIFIPASS=$(echo "  Enter password or Press Enter if network is saved" | wofi -d -c $conf/pass_config)
		fi
		if nmcli dev wifi con "$CHSSID" password "$WIFIPASS"
		then
			notify-send 'Connected!'
			echo 'Conenction :)'
		else
			echo 'Connection :('
			notify-send 'Connection failed'
		fi
	fi
fi
