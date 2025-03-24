#!/bin/bash

set -xe

ffprobe -v error -select_streams v:0 -show_frames -of json $1 | jq -c '.frames[] | {pts_time: .pkt_pts_time, duration: .pkt_duration_time}' > $1-frame-timing.json
