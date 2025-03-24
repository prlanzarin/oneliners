#!/bin/bash

set -xe

# Print audio packets out to an CSV file
ffprobe -v quiet -show_packets -select_streams v:0 -read_intervals 110%120 -show_entries packet=pts,pts_time,dts,dts_time,duration,duration_time,size,pos,flags -of csv=p=0 $1 > $2
