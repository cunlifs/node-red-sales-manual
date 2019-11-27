#!/bin/sh
# Copy flows file to new location
chmod 750 /usr/src/node-red/sales-manual-reader-flow.json
HOSTNAME_SHORT=`hostname -s`
#cp -p /usr/src/node-red/sales-manual-reader-flow.json /usr/src/node-red/.node-red/flows_$HOSTNAME_SHORT.json
