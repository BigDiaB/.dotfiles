#!/bin/bash

PID=$(xdotool getwindowpid $(xdotool getwindowfocus))
i3-msg move container scratchpad
sleep  1 
kill $PID
