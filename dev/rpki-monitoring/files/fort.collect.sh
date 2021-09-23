#!/bin/bash

container="fort"
OUTPUT=/var/local/fort/roas.csv

vrp_count=$(docker exec $container wc -l $OUTPUT | cut -d" " -f1 )

echo rpki,repo=lacnic,validator=fort,mode=rrdp vrp_count=$vrp_count $(date +%s%N)