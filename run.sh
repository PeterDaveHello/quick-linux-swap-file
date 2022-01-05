#!/bin/sh -e

if [ "0" != "$(id -u)" ]; then
    echo 1>&2 "I need root permission!"
    exit 1
fi

SWAP_FILE="${SWAP_FILE:-/swapfile}"
SWAP_SIZE="${SWAP_SIZE:-512M}"

echo "Try to create a swap file: $SWAP_FILE with size $SWAP_SIZE"

fallocate -l "$SWAP_SIZE" "$SWAP_FILE"
chmod 0600 "$SWAP_FILE"
mkswap "$SWAP_FILE"
swapon -a

### write to fstab if needed ###
# echo "$SWAP_FILE    none    swap    sw    0   0" | tee -a /etc/fstab

swapon -s
