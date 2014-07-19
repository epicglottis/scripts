#!/bin/bash
if [ -z "$1" ]; then
  printf '\33]50;%s%d\007' "xft:Ubuntu Mono:antialias=false:hinting=true:pixelsize=" 16
else
  printf '\33]50;%s%d\007' "xft:Ubuntu Mono:antialias=false:hinting=true:pixelsize=" $1
fi
