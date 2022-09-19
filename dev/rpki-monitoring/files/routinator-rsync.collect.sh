#!/bin/bash

container="routinator-rsync"

vrp_count=$(docker exec $container routinator vrps | grep lacnic | wc -l)

if [ "$vrp_count" = "0" ]; then
    echo "Zero rows, probably still starting/running... $container"
else
    echo rpki,repo=lacnic,validator=routinator,mode=rsync vrp_count=$vrp_count $(date +%s%N)
fi