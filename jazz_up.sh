#!/bin/bash
# jazz up: arvotaan sopiva määrä jazzia alle tietyn aikarajan.

# Argumentit {{{
# minuutit ovat 1. argumentti
mins="$1" ; [ -z "$1" ] && mins=15

# argumentin validius on tärkeää, ettei jouduta ikilooppiin.
# Ei kuitenkaan tarkasta argumentin numeerisuutta.
if [ "$mins" -le 0 ]  ; then
    echo Väärä aika: $mins
    exit 1
fi

# soittolista toinen vaihtoehtoinen
playlist="$2" ; [ -z "$2" ] && playlist="dinnerjazz"
#}}}

echo -n Haetaan $mins minuuttia musiikkia...
mpc clear            > /dev/null
mpc load "$playlist" > /dev/null
mpc shuffle          > /dev/null

# funktionaalisesti voittoon: kerätään listan ajat taulukkoon.
# awk: lisää printtiin +$2, jos haluat tarkat kappaleajat käyttöön.
declare -a LENGTH=(`mpc --format "%time%" playlist | awk -F: '{print $1*60 }'`)

# lasketaan kertaalleen koko summa näistä.
# tehdäänpä sekin funktionaalisesti
TOTALTIME=`echo ${LENGTH[*]} | tr ' ' '+' | bc`

# nyt varsinainen bisneslogiikka taas.
i=0
(( requiredtime = mins*60 ))

while [ "$TOTALTIME" -gt "$requiredtime" ]
do
    mpc del 1       > /dev/null
    timerem=${LENGTH[$i]}
    (( TOTALTIME = TOTALTIME - timerem ))
    (( ++i ))
done

echo \ saimme $((TOTALTIME/60)) min
mpc play

