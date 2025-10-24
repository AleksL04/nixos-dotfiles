#!/usr/bin/env bash
wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bash /home/aleks/.config/scripts/update-mic-led.sh