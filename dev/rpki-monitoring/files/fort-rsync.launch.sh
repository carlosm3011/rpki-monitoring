#!/bin/bash
# Launch fort inside a docker container - RSYNC VERSION
#
##

docker run -d --restart unless-stopped \
        --name fort-rsync \
        -v /opt/rpkimon/tals/lacnic:/etc/fort/tal:ro \
        nicmx/fort-validator \
        --tal /etc/fort/tal/lacnic.tal \
        --output.roa /var/local/fort/roas.csv \
        --http.enabled=false \
        --log.level=info 

# docker run -d --restart unless-stopped \
#         --name fort_rsync \
#         -v /opt/rpkimon/tals/lacnic:/etc/fort/tal:ro \
#         -d nicmx/fort-validator \
#         --tal /etc/fort/tal/lacnic.tal \
#         --output.roa /var/local/fort/roas.csv \
#         --server.interval.validation 300 \
#         --log.output console \
#         --log.level info \
#         --http.enabled=false \
#         --log.enabled=true \
#         --log.level=warning \
#         --log.output=syslog \        

