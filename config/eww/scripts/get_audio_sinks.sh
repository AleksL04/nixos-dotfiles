#!/usr/bin/env bash

# Use pactl to get sink-inputs, and jq to format as JSON
pactl -f json list sink-inputs | jq -c '[.[] | {
    index: .index, 
    name: .properties."application.name", 
    volume: ((.volume | to_entries[0].value.value_percent) | sub("%"; "") | tonumber), 
    muted: .mute
}]'
