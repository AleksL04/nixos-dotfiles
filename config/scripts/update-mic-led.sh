#!/usr/bin/env bash
micStatus=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -c MUTED)
brightnessctl -d platform::micmute set "$micStatus"