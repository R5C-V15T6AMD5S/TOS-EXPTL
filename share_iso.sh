#!/bin/sh

if [ ! -d "shr" ]; then
    echo "ERROR: the shared folder (shr) doesn't exist"
    exit 1
fi

set -xe

genisoimage -o SHR.iso shr

