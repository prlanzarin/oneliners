#!/bin/bash

ffprobe -v error -show_streams -of json $1
