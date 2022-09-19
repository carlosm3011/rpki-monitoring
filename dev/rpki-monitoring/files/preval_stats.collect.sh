#!/bin/bash

TEMP=$(mktemp /tmp/rpki_backend.XXXXX)

curl -s http://rrdp-fe-atl1.lacnic.net/salidawc > $TEMP

timestamp=$(cat $TEMP | cut -d " " -f1 )000000000
vrp_count=$(cat $TEMP | cut -d " " -f2 )
# echo rpki,repo=lacnic,validator=fort vrp_count=$vrp_count $(date +%s%N)
echo rpki,repo=lacnic_i,validator=fort,frontend=rrdp-fe-atl1 vrp_count=$vrp_count $timestamp

rm $TEMP