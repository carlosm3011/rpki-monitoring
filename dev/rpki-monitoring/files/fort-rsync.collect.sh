#!/bin/bash

container="fort-rsync"
OUTPUT=/var/local/fort/roas.csv

vrp_count=$(docker exec $container wc -l $OUTPUT | cut -d" " -f1 )

if [ "$vrp_count" = "0" ]; then
    echo "Zero rows, probably still running... $container"
else
    echo rpki,repo=lacnic,validator=fort,mode=rsync vrp_count=$vrp_count $(date +%s%N)
fi
