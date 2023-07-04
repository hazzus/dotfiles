#!/bin/zsh

arg=$1
ttl=$((ttl * 1000))
notification_id=$(dunstify -p -t $ttl "Screen will be locked soon")
paplay $(dirname $0)/notify.wav &

trap "dunstify -C $notification_id; exit" SIGINT SIGTERM SIGKILL

while true; do
    sleep 1
done
