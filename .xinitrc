#!/bin/sh

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -load ~/.Xresources
xset r rate 500 30
xsetroot -solid "#000000"
urxvtd -q -o -f

xautolock -time 15 -locker "i3lock -c 000000" &
redshift &

exec i3
