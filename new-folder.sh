#!/bin/sh

if [ $# -lt 2 ]; then
    echo "Usage: ./new-folder.sh <TOS.img> <folder>"
    echo "ERROR: not enough arguments is provided"
    exit 1
fi

set -xe

. ./config.sh

./mount.sh "$1"

cd "$QEMU_IMG_MOUNT_DIR/Home/Coding-Shit/"
mkdir -p "$2"
#cp "./Template.HC" "$2/Main.HC"
#ed "$2/sample.TXT"
#ed "$2/input.TXT"
