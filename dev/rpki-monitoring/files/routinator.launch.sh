#!/bin/bash

cd /opt/rpkimon/routinator

docker run -d --restart unless-stopped --name routinator  \
    -v /opt/rpkimon/tals:/home/routinator/.rpki-cache/tals \
    -p 3323:3323 \
    -p 9556:9556 \
    nlnetlabs/routinator:latest