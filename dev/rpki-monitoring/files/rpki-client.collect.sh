#!/bin/bash

container="rpki-client"
OUTPUT=/var/lib/rpki-client/csv

vrp_count=$(docker exec $container grep lacnic $OUTPUT | wc -l )

echo rpki,repo=lacnic,validator=rpki-client,mode=rsync vrp_count=$vrp_count $(date +%s%N)