#!/bin/bash

if [ -z "${CURATOR_CRON}" ]; then
    echo "env \$CURATOR_CRON is not defined"
    exit;
fi

while true; do
    /usr/local/bin/curator delete indices --prefix logstash --older-than 14 --time-unit days --timestring "%Y.%m.%d"
    /usr/local/bin/curator delete indices --prefix logstash --disk-space 8 --time-unit days --timestring "%Y.%m.%d"
    /usr/local/bin/curator bloom indices --prefix logstash --older-than 7 --time-unit days --timestring "%Y.%m.%d"
    /usr/local/bin/curator optimize indices --prefix logstash --older-than 1 --time-unit days --timestring "%Y.%m.%d"
    /usr/local/bin/curator allocation --rule tag=done_indexing indices --prefix logstash --older-than 1 --time-unit days --timestring "%Y.%m.%d"

    sleep $((24*60*60))
done