# ~/.config/eww/scripts/control_audio.sh
#!/usr/bin/env bash

ACTION=$1
SINK_INDEX=$2
VOLUME=$3

case "$ACTION" in
    set_volume)
        pactl set-sink-input-volume "$SINK_INDEX" "${VOLUME}%"
        ;;
    toggle_mute)
        pactl set-sink-input-mute "$SINK_INDEX" toggle
        ;;
esac
