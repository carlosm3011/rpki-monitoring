#!/bin/bash

container="routinator"

vrp_count=$(docker exec routinator routinator vrps | grep lacnic | wc -l)

echo rpki,repo=lacnic,validator=routinator,mode=rrdp vrp_count=$vrp_count $(date +%s%N)