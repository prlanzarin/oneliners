#!/bin/bash

set -xe

ffprobe -v error -select_streams v:0 -skip_frame nokey -show_frames -of csv recording.webm | \
  awk -F',' '{print $3}' | \
  awk '{if (NR>1) print $1-prev; prev=$1}' | \
  sort | uniq -c
