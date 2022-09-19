#!/bin/bash
#
# Routinator RSYNC

cd /opt/rpkimon/routinator


docker run -d --restart unless-stopped --name routinator-rsync  \
    -v /opt/rpkimon/tals/lacnic:/home/routinator/.rpki-cache/tals \
    -p 3324:3323 \
    -p 9557:9556 \
    nlnetlabs/routinator:latest \
    --disable-rrdp \
    server