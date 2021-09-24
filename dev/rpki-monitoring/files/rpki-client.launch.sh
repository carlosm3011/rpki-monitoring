#!/bin/bash

cd /opt/rpkimon/rpki-client

mkdir -p output
mkdir -p cache

docker run -d --name rpki-client \
           --volume /opt/rpkimon/tals/lacnic:/etc/tals \
    	   --volume $(pwd)/output:/var/lib/rpki-client \
	       --volume $(pwd)/cache:/var/cache/rpki-client \
           --detach rpki/rpki-client:latest