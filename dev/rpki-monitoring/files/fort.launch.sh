# Launch fort inside a docker container
#
##

# # docker run --restart always --name fort \
# docker run --name fort \
#         -v /opt/rpkimon/tals:/etc/fort/tal:ro \
#         # -v /opt/rpkimon/fort/fort.conf:/etc/fort/fort.conf \
#         -p 1323:323 -d nicmx/fort-validator \
#         --tal /etc/fort/tal/lacnic.tal --output.roa /var/local/fort/roas.csv --server.interval.validation 300 \
#         --log.output console --log.level info

# docker run --name fort \
docker run -d --restart unless-stopped --name fort \
        -v /opt/rpkimon/tals:/etc/fort/tal:ro \
        -p 1323:323 -d nicmx/fort-validator \
        --tal /etc/fort/tal/lacnic.tal --output.roa /var/local/fort/roas.csv --server.interval.validation 300 \
        --log.output console --log.level info
