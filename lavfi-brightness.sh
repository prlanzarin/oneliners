#!/bin/bash

set -xe

INPUT_FILE=$1

ffprobe -v error -f lavfi "movie="$INPUT_FILE",signalstats=stat=all:out=brng" -show_entries frame=pkt_pts_time:frame_tags=lavfi.signalstats.BRNG -of csv
