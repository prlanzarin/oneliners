#!/bin/bash

set -xe

ffprobe -v error -select_streams v:0 -show_frames -of json recording.webm | \
  jq -r '.frames[] | .pkt_pts_time' | \
  awk '{if (NR>1) {diff=$1-prev; if (diff>0.1) print NR-1, prev, NR, $1, diff}; prev=$1}'
