#!/usr/bin/env bash

if ! [ -n "${GOOGLE_LATITUDE_OAUTH_TOKEN}" ]; then
  echo "Please set the GOOGLE_LATITUDE_OAUTH_TOKEN environment vairable"
  exit 1
fi

if ! [ -n "${FORECAST_IO_KEY}" ]; then
  echo "Please set the FORECAST_IO_KEY environment vairable"
  exit 1
fi

location=$(curl --header "$GOOGLE_LATITUDE_OAUTH_TOKEN" https://www.googleapis.com/latitude/v1/currentLocation?granularity=best)
latitude=$(echo $location | cut -d ',' -f 3 | cut -d ':' -f 2)
longitude=$(echo $location | cut -d ',' -f 4 | cut -d ':' -f 2)

current_time=$(date +"%s")
forecast=$(curl https://api.forecast.io/forecast/$FORECAST_IO_KEY/$latitude,$longitude,$current_time?exclude=minutely,hourly,daily,alerts,flags)
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
