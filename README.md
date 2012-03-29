# jazz_up

A bash script to shuffle an MPD playlist and fit it to given time limit.
Requires `mpc` the MPD client.

Motivation:  waiting for the hair to dry, or have something nice for the
dinner. We want music for some time but it's hard to pick an album that fits
the time constraints. Using this script, you can define MPD playlists and this
script will pick a random selection from it. Not optimal, but most of the time
it gets close to the wanted amount of time.

## Usage

`jazz_up.sh <MINUTES> <PLAYLIST>` gets you about MINUTES minutes of tracks from
MPD playlist of PLAYLIST.
