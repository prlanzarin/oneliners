#!/bin/bash

set -xe

ffprobe -v error -select_streams v:0 -show_frames -of json $1 | jq '.frames[] | select(.pict_type=="I") | .pkt_pos' | wc -l

