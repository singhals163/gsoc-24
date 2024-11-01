#!/bin/bash

# Success path (out)
out() {
    exit 0
}

# Error handling path (error)
error() {
    exit 1
}

# Define the target directory for mounting
dir="/tmp/root"

# Create the directory if it doesn't exist
mkdir -p "$dir"

# Parse the root= parameter from /proc/cmdline
root_partition=$(grep -oP '(?<=\broot=)[^\s]+' /proc/cmdline)

# Check if root partition was found, call error if not
if [ -z "$root_partition" ]; then
    echo "Error: Could not determine the root partition from /proc/cmdline."
    error
fi

echo "Mounting root partition: $root_partition to $dir"

# Mount the root partition to the target directory
mount -t auto "$root_partition" "$dir"
if [ $? -ne 0 ]; then
    echo "Error: Failed to mount $root_partition to $dir"
    error
fi

# Run the modified command with -xdev to restrict to the same partition
hash_result=$(
  {
    find "$dir" -xdev -type f -print0 | xargs -0 sha256sum | sort -k 1,1 -z;
    find "$dir" -xdev \( -type f -o -type d \) -print0 | xargs -0 stat -c '%n %a' | sha256sum | sort -k 1,1 -z;
  } | sha256sum | awk '{print $1}'
)

umount "$dir"
if [ $? -ne 0 ]; then
    echo "Warning: Failed to unmount $dir"
fi

# Write the calculated hash to /run/aktualizr/root-hash
mkdir -p /run/aktualizr
echo "$hash_result" > /run/aktualizr/root-hash
if [ $? -ne 0 ]; then
    echo "Error: Failed to write hash to /run/aktualizr/root-hash"
    error
fi

echo "Hash successfully written to /run/aktualizr/root-hash."
out
