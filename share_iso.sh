#!/bin/sh

if [ ! -d "shr" ]; then
    echo "ERROR: the shared folder (shr) doesn't exist!"
    echo -e "Creating the shared folder...\n"
    mkdir shr
fi

set -xe

genisoimage -o SHR.iso shr

