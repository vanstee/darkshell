#!/usr/bin/env bash

oauth_token=$1
forcast_key=$2

location=$(curl --header "$oauth_token" https://www.googleapis.com/latitude/v1/currentLocation?granularity=best)
latitude=$(echo $location | cut -d ',' -f 3 | cut -d ':' -f 2)
longitude=$(echo $location | cut -d ',' -f 4 | cut -d ':' -f 2)

current_time=$(date +"%s")
forecast=$(curl https://api.forecast.io/forecast/$forcast_key/$latitude,$longitude,$current_time?exclude=minutely,hourly,daily,alerts,flags)
icon=$(echo $forecast | cut -d ',' -f 7 | cut -d ':' -f 2 | sed s/\"//g)

case "$icon" in
  "clear-day")
    echo "☼"
    ;;
  "clear-night")
    echo "☾"
    ;;
  "thunderstorm")
    echo "⚡"
    ;;
  "rain")
    echo "☔"
    ;;
  "snow")
    echo "❆"
    ;;
  "sleet")
    echo "❄"
    ;;
  "wind")
    echo "⚐"
    ;;
  "fog")
    echo "☁"
    ;;
  "cloudy")
    echo "☁"
    ;;
  "partly-cloudy-day")
    echo "☼"
    ;;
  "partly-cloudy-night")
    echo "☆"
    ;;
esac
