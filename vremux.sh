#!/bin/bash

set -xe

INPUT_FILE=$1

ffmpeg -v error -i $INPUT_FILE -vcodec copy -acodec copy $INPUT_FILE-rem.webm
