#!/usr/bin/env bash

oauth_token=$1

location=$(curl --header $oauth_token https://www.googleapis.com/latitude/v1/currentLocation?granularity=best)
latitude=$(echo $location | cut -d ',' -f 3 | cut -d ':' -f 2)
lognitude=$(echo $location | cut -d ',' -f 4 | cut -d ':' -f 2)
