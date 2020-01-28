#!/bin/bash
set -eufx

# Available settings:
# gstsrc: The gstreamer pipeline to extract the image.
# imagewidth: Output image width.
# imageheight: Output image height.
# framerate: Output framerate.

# Settings for using a Raspberry Pi camera module
# These have been tested as working well with the Raspberry Pi camera module.
#gstsrc="rpicamsrc name=src preview=0 exposure-mode=night fullscreen=0 bitrate=1000000 annotation-mode=time+date annotation-text-size=20"
#imagewidth=960
#imageheight=540
#framerate=12

# Sample settings for USB webcams
#################################
# Logitech C920 Pro.
# These settinsg will work for the C920, and should be OK for other cameras
# that can export an H264 stream.
# These have been confirmed working with a Logitech C920 Pro.
# Try to list compatible image and framerate settings with
# `v4l2ctl -d /dev/video0 --list-formats-ext`
#gstsrc="v4l2src name=src device=/dev/video0"
#imagewidth=960
#imageheight=720
#framerate=15

# Generic webcam settings
# These should work for any webcam.
imagewidth=960
imageheight=720
framerate=15
gstsrc="v4l2src name=src device=/dev/video0 ! video/x-raw,width=$imagewidth,height=$imageheight,framerate=$framerate/1 ! h264enc"

gst-launch-1.0 -v $gstsrc ! \
               video/x-h264,width=$imagewidth,height=$imageheight,framerate=$framerate/1 ! \
               queue max-size-bytes=0 max-size-buffers=0 ! h264parse ! \
               rtph264pay config-interval=1 pt=96 ! queue ! \
               udpsink host=127.0.0.1 port=5004 \
               alsasrc device=hw:1 ! audioconvert ! audioresample ! \
               opusenc ! rtpopuspay ! \
               queue max-size-bytes=0 max-size-buffers=0 ! \
               udpsink host=127.0.0.1 port=5002
