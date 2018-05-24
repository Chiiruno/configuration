#!/bin/sh
pacmd load-module module-alsa-sink device=hw:$(aplay -l | grep "USB Audio #1" | cut -c 6),1
