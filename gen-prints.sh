#!/bin/bash

INPUT_FILE=$1
MAX_FRAMES=$2

set -xe

# IF 0 or not set, then process all frames
if [ -z "$MAX_FRAMES" ] || [ "$MAX_FRAMES" -eq 0 ]; then
  ffmpeg -i $INPUT_FILE -vf "fps=1/0.1,select=between(t\,0\,300),drawtext=text='pts=%{pts}':x=10:y=10:fontsize=24:fontcolor=red" -crf 18 $INPUT_FILE-prints-debug_%05d.png
else
  ffmpeg -i $INPUT_FILE -vf "fps=1/0.1,select=between(t\,0\,300),drawtext=text='pts=%{pts}':x=10:y=10:fontsize=24:fontcolor=red" -crf 18 -frames:v $MAX_FRAMES $INPUT_FILE-prints-debug_%05d.png
fi
