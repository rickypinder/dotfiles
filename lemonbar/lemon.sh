#!/usr/bin/bash

Clock() {
	DATETIME=$(date "+%a %b %d, %T")
	echo -n "$DATETIME"
}

Battery() {
	BATPERC=$(acpi --battery | awk '{print $4 " " $5}')
    CHARGING=$(acpi --battery | awk '{print $3}')

    if [ $CHARGING == "Charging," ]
    then
        echo -n "%{F#00FF00}$BATPERC %{F-}"
    else
        echo -n "$BATPERC %{F-}"
    fi
}

Volume() {
	VOL=$(awk '/%/ {gsub(/[\[\]]/,""); print $4}' <(amixer sget Master))
    MUTED=$(amixer sget Master | grep "Mono:" | awk '{print $6}')

    if [ $MUTED == "[on]" ]
    then
        echo -n "Volume: $VOL %{F-}"
    else
        echo -n "Volume: %{F#FF0000}$VOL %{F-}"
    fi
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
			echo -n " %{B#FF0000} $i %{B-}"
		else
			echo -n "  $i "
		fi
	done
}

while true; do
	echo "$(Workspaces) %{r} $(Brightness) | $(Volume) | $(Power) | $(Battery) | $(Clock)"
	sleep 0.5
done
