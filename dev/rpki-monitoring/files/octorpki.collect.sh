#!/bin/bash

container="octorpki"
OUTPUT=/tmp/roas-octorpki.json

vrp_count=$(curl -s localhost:18080/cache/output.json  | jq '.roas[].prefix' | wc -l )

echo rpki,repo=lacnic,validator=octorpki,mode=rrdp vrp_count=$vrp_count $(date +%s%N)