#!/bin/bash

INPUT_FILE=$1

set -xe

ffmpeg -i $INPUT_FILE -vf "select=between(t\,0\,300),drawtext=text='pts=%{pts}':x=10:y=10:fontsize=24:fontcolor=red" $INPUT_FILE-pts.webm
