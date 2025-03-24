#!/bin/bash
#
#ffprobe -v error -select_streams v:0 -show_frames read_intervals "%+#500" -of json $1 | \
ffprobe -v error -select_streams v:0 -show_frames -of json $1 | \
  jq -c '.frames[] | {pts_time: .pkt_pts_time, key_frame: .key_frame, pict_type: .pict_type, pkt_size: .pkt_size, width: .width, height: .height, pkt_flags: .pkt_flags}'

