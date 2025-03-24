#!/bin/bash

set -xe

ffmpeg -v error -i $1 -f null - 2>&1 | grep -i "error\|corrupt"

