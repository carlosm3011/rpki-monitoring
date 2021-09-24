#!/bin/bash

cd /opt/rpkimon/octorpki
mkdir -p cache

docker run -d \
        --restart unless-stopped \
        --name octorpki \
        -v /opt/rpkimon/tals/lacnic:/tals \
        -v $(pwd)/cache:/cache \
        -p 18080:8081 cloudflare/octorpki \
        -mode server -output.roa /cache/output.json -refresh 5m 