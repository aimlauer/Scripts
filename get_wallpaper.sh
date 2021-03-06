#!/usr/bin/bash
# RATING: questionable, explicit, safe
RATING="questionable"
FOLDER_TO_SAVE="/tmp"

if [ ! "$(command -v feh)" ]; then echo "bro, you need to install feh"; exit; fi

RESOLUTION=$(xrandr | grep '*' | awk '{print $1}') &&
WIDTH=$(echo $RESOLUTION | cut -d 'x' -f 1) &&
HEIGHT=$(echo $RESOLUTION | cut -d 'x' -f 2) &&
echo "Your resolution is $WIDTH x $HEIGHT" &&

GET_WALL=$(curl -s https://konachan.com/post.json?tags=%20width:$WIDTH%20height:$HEIGHT%20rating:$RATING%20order:random limit:1 | jq -r '.[0]["file_url"]') &&
echo "Downloading and setting wallpaper" &&

name=$(date "+%m%M%d%H%S") &&
ext=${GET_WALL##*.} &&
FILE="$FOLDER_TO_SAVE/$name.$ext" &&
echo "Saving image in $FILE" &&

curl -s $GET_WALL --output - > $FILE &&
echo "Saved in $FILE" &&
feh --bg-max $FILE &&
echo "Done"
