#!/bin/bash
# jazz up: shuffle a selection of music within given time limit.

# Arguments {{{
# First, minutes
mins="$1" ; [ -z "$1" ] && mins=15

# Basic checks of time validity. Numberness is yet to test...
if [ "$mins" -le 0 ]  ; then
    echo Bad time: $mins
    exit 1
fi

# Second, the playlist.  The original author prefers a playlist called
# "dinnerjazz" as this was written specifically for that purpose
playlist="$2" ; [ -z "$2" ] && playlist="dinnerjazz"
#}}}

echo -n Finding $mins minutes of music... 
mpc clear            > /dev/null
mpc load "$playlist" > /dev/null
mpc shuffle          > /dev/null

# Functionality for the win. Collect track times in an array.
# awk: modify print to have `+$2`, if you want to deal with exact times.
declare -a LENGTH=(`mpc --format "%time%" playlist | awk -F: '{print $1*60 }'`)

# total time, also functionally
TOTALTIME=`echo ${LENGTH[*]} | tr ' ' '+' | bc`

# no longer functional.
i=0
(( requiredtime = mins*60 ))

while [ "$TOTALTIME" -gt "$requiredtime" ]
do
    mpc del 1       > /dev/null
    timerem=${LENGTH[$i]}
    (( TOTALTIME = TOTALTIME - timerem ))
    (( ++i ))
done

echo \ we got $((TOTALTIME/60)) min
mpc play

