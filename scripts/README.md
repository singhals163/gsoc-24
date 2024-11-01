## Scripts
This directory contains a couple of scripts which control the behavior of RAUC which runs as a systemd service on TorizonOS. The package manager was integrated in the [gsoc-manifest](https://github.com/rborn-tx/gsoc-manifest) repository.

### Usage
1. `calc-root-hash.sh`
   - The script is responsible for calculating the content-hash of the current root partition booted on the device
   - It mounts the current partition to `/tmp/root` and calculates a content-hash of the partition 
   - It further writes this hash to /run/aktualizr/root-hash which is read by the aktualizr service for verifying the correctness of currently installed rootfs
2. `pre-install-handler.sh`
    - This script verifies if the root-digest(as calculated by RAUC while creating the bundle) reported by the two files is same:
      - Uptane Manifest
      - Bundle Manifest
    - If the hashes do not match, the scripts returns an error because of which RAUC stops the installation of bundle and returns an error via DBus API
    - The error is read by aktualizr and properly reported
3. `system.conf`
    - This is a RAUC config file which gives RAUC a picture of the current state of device
    - The `[handlers]` section makes RAUC configurable 
    - The current implementation only required the `pre-install-handler` as mentioned in the previous point