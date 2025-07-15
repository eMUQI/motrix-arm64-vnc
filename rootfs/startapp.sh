#!/bin/bash

export HOME=/config

cd /opt/motrix

export APPDIR="/opt/motrix"

export LD_LIBRARY_PATH="/opt/motrix:/opt/motrix/usr/lib:${LD_LIBRARY_PATH}"

exec ./AppRun --no-sandbox "$@"
