#!/bin/bash

# Get the directory path from the first argument
dir="$1"

# Run the modified command with -xdev to restrict to the same partition
(
  find "$dir" -xdev -type f -print0 | xargs -0 sha256sum | sort -k 1,1 -z;
  find "$dir" -xdev \( -type f -o -type d \) -print0 | xargs -0 stat -c '%n %a' | sha256sum | sort -k 1,1 -z
) | sha256sum | awk '{print $1}'
