#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Usage: ./run.sh <TOS.img>"
    echo "ERROR: no path to image is provided"
    exit 1
fi

set -xe

. ./config.sh

sync
sudo umount $QEMU_IMG_MOUNT_DIR || true

# Define paths to supplemental ISOs
SUPPLEMENTAL1_PATH="/home/o5-15/VirtualBox/TempleOS/shr/TOS_Supplemental1.ISO.C"  # Utilities & Games
SUPPLEMENTAL2_PATH="/home/o5-15/VirtualBox/TempleOS/shr/TOS_Supplemental2.ISO.C"  # Generated Songs Pt. 1
SUPPLEMENTAL3_PATH="/home/o5-15/VirtualBox/TempleOS/shr/TOS_Supplemental3.ISO.C"  # Generated Songs Pt. 2

$QEMU_SYSTEM_X86_64 $QEMU_FLAGS \
    -drive file="$1",format=raw \
    -cdrom "$TEMPLEOS_ISO" \
    -drive file="$SUPPLEMENTAL1_PATH",media=cdrom 
