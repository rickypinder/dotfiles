#!/usr/bin/bash

Clock() {
	DATETIME=$(date "+%a %b %d, %T")
	echo -n "$DATETIME"
}

Battery() {
	BATPERC=$(acpi --battery | awk '{print $4 " " $5}')
	echo -n "$BATPERC"
} 

Volume() {
	VOL=$(awk '/%/ {gsub(/[\[\]]/,""); print $4}' <(amixer sget Master))   
	echo -n "Volume: $VOL"
}

Brightness() {
	BRIGHTNESS=$(xbacklight | grep -o '^[^.]\+')
	echo -n "Brightess: $BRIGHTNESS%"
}

Power() {
	POWER=$(awk '{print $1*10^-6}' /sys/class/power_supply/BAT0/power_now)
	echo -n "$POWER W"

}

Workspaces() {
	CURRENT_WORKSPACE=$(xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}')
	let "CURRENT_WORKSPACE++"

	for i in {1..10}
	do
		if [ "$i" -eq "$CURRENT_WORKSPACE" ]
		then
			echo -n " <$i>"
		else
			echo -n "  $i "
		fi
	done
}

while true; do
	echo "$(Workspaces) %{r} $(Brightness) | $(Volume) | $(Power) | $(Battery) | $(Clock)"
	sleep 0.5
done
