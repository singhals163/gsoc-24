#!/bin/bash

echo "Pre-install-handler is running" 

# Loop through each target slot and check the corresponding digest
for i in $RAUC_TARGET_SLOTS; do
    # Use the correct digest variable for the current slot
    eval RAUC_IMAGE_DIGEST=\$RAUC_IMAGE_DIGEST_${i}
#    echo $RAUC_IMAGE_DIGEST
#    cat /run/aktualizr/expected-digest
    # Check if the digest matches the expected value
    if [ "$RAUC_IMAGE_DIGEST" = "$(cat /run/aktualizr/expected-digest)" ]; then
        echo "Condition is true: Digest for slot $i matches."
    else
        echo "Condition is false: Digest for slot $i does not match."
        exit 1  # Exit with non-zero exit code if any digest does not match
    fi
done

# If all digests match, exit with 0
exit 0
