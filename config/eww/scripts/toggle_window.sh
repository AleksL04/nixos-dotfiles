#!/usr/bin/env bash

WINDOW="$1"

if eww active-windows | grep -q "$WINDOW"; then
    eww close "$WINDOW"
else
    eww open "$WINDOW"
fi
