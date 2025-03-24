#!/bin/bash

set -xe

INPUT_FILE=$1

ffprobe -v error -f lavfi "movie="$INPUT_FILE",blackframe=amount=80:threshold=32[out0]" -show_entries frame=pkt_pts_time,pkt_dts_time -of csv
