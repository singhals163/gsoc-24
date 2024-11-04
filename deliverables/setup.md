## Building support for an A/B partition scheme-based update for Uptane Client

### Usage

We will follow the following directory structure for the project:
```
~
|--gsoc-workdir
|  |--aktualizr (contains aktualizr source code)
|  |--gsoc-2024 (yocto build files for the project)
|  |--torizon-cloud (directory for pushing image to torizon cloud)
|  |--calc-root-hash-dev.sh (for calculating the content-hash)
|  |--images (stores versions of the bundles and root images)
|  |  |--v1.0
|  |  |  |--update-bundle-verdin-imx8mm.raucb (rauc bundle)
|  |  |  |--torizon-minimal-verdin-imx8mm-<xyz>.rootfs.ext4 (rootfs image)
|  |  |  |--metadata (contains the content-hash and digest of the image)
|  |  |--v1.1
|  |  .
|  |  .
|  |  .
|  |  |--v2.0
```

### Basic Steps

1. Initial Setup
2. Setting up the build directory
3. Build root image and update bundle
4. Find the root-digest and root-content-hash
5. Uploading metadata to Torizon Cloud
6. Trigger updates through Torizon Cloud

### Initial setup: 

- Clone aktualizr repository:
  ```
  ~:
  $ git clone https://github.com/singhals163/gsoc-24.git gsoc-workdir
  $ cd gsoc-workdir

  ~/gsoc-workdir: 
  $ git clone --recursive <link to final repo> -b <final branch name> aktualizr
  ```
- Setup torizon-cloud directory: 
  ```
  ~/gsoc-workdir: 
  $ mkdir torizon-cloud && cd torizon-cloud

  ~/gsoc-workdir/torizon-cloud:
  $ docker pull torizon/torizoncore-builder:3
  $ alias uptane-sign='docker run --rm -it -u $(id --user):$(id --group) -v /deploy -v "$(pwd)":/workdir -v storage:/storage -v /var/run/docker.sock:/var/run/docker.sock --network=host --entrypoint uptane-sign torizon/torizoncore-builder:3'
  $ uptane-sign --help
  # Download your credentials file from Torizon Cloud server in torizon-cloud directory
  $ uptane-sign init --repo image-repo --credentials credentials.zip
  ```
- Create the images directory and host nginx server: 
  ```
  ~/gsoc-workdir: 
  $ mkdir -p images && cd images

  ~/gsoc-workdir/images:
  $ docker run -p 8080:80 -v $(pwd):/usr/share/nginx/html nginx
  ```

### Setting up the build directory

- **Follow steps 1, 2 and 3** from Rogerio's guide to build a Torizon OS image with RAUC support: [gsoc-manifest](https://github.com/rborn-tx/gsoc-manifest)
- Setup the `local.conf` for the project:
  ```
  ~/gsoc-workdir/gsoc-2024/build-torizon:
  $ vi conf/local.conf
  # Append the following lines to that file:
  INHERIT += "externalsrc"
  EXTERNALSRC:pn-aktualizr = "/home/<USERNAME>/gsoc-workdir/aktualizr"
  IMAGE_INSTALL:append = "aktualizr-auto-reboot"
  ```
- Build the following for using rauc-native (used for finding sha256 digest of the rootfs):
  ```
  ~/gsoc-workdir/gsoc-2024:
  $ MACHINE=verdin-imx8mm . ./setup-environment 
  
  ~/gsoc-workdir/gsoc-2024/build-torizon:
  $ bitbake rauc-native
  $ bitbake rauc-native -caddto_recipe_sysroot
  ```

### Build root image and update bundle

- Build the project:
  ```
  ~/gsoc-workdir/gsoc-2024/build-torizon:
  $ bitbake update-bundle
  ```
- **Note**: You will have to manually install the image to the device for the first time. Follow the 5th Step mentioned in [Rogerio's setup repo](https://github.com/rborn-tx/gsoc-manifest?tab=readme-ov-file#install-os-image).

### Find the root-digest and root-content-hash

- Copy the required files for new image:
  ```
  ~/gsoc-workdir:
  $ mkdir -p images/v1.0
  
  ~/gsoc-workdir/gsoc-2024/build-torizon/deploy/images/verdin-imx8mm:
  $ cp torizon-minimal-verdin-imx8mm-*rootfs.ext4 ~/gsoc-workdir/images/v1.0/
  $ cp update-bundle-verdin-imx8mm.raucb ~/gsoc-workdir/images/v1.0/
  ```
- Find content-hash:
  ```
  ~/gsoc-workdir:
  $ sudo mkdir -p /tmp/root
  $ sudo mount -o loop images/v1.0/torizon-minimal-verdin-imx8mm-*.rootfs.ext4 /tmp/root

  # calculates the content-hash and prints it
  $ sudo ./calc-root-hash-dev.sh /tmp/root
  $ sudo umount /tmp/root
  ```
- Find the hash digest reported by rauc:
  ```
  ~/gsoc-workdir/gsoc-2024/build-torizon:
  $ oe-run-native rauc-native rauc info deploy/images/verdin-imx8mm/update-bundle-verdin-imx8mm.raucb --keyring=rauc-keys/ca.cert.pem 
  ```

### Uploading metadata to Torizon Cloud

- Follow these steps:
  ```
  ~/gsoc-workdir/torizon-cloud:

  $ uptane-sign targets pull --repo image-repo [--verbose]
  $ uptane-sign targets upload --repo image-repo --input ../images/v1.0/update-bundle-verdin-imx8mm.raucb --name update-bundle-verdin-imx8mm.img --version v1.0 [--verbose]
  $ uptane-sign targets add-uploaded \
      --repo image-repo --input ../images/v1.0/update-bundle-verdin-imx8mm.raucb --name update-bundle-verdin-imx8mm.img --version v1.0 \
      --hardwareids verdin-imx8mm-rauc \
      --customMeta '{
          "rauc": {
              "rawHashes": {
                  "sha256": "<hash-digest>"
              }
          }
      }'

  $ nano tuf/image-repo/roles/unsigned/targets.json
  # edit the file to modify the hash to match the directory hash.
  #
  #   change the value of hashes.sha256 to <content-hash> calculated above
  #   change the value of uri to http://<ip address>:8080/v1.0/update-bundle-verdin-imx8mm.raucb

  $ uptane-sign targets sign --repo image-repo --key-name targets [--verbose]
  $ uptane-sign targets push --repo image-repo [--verbose]
  ```

### Trigger updates through Torizon Cloud

- Register your device at the Torizon Cloud
- Trigger the first update through Torizon Cloud
- To monitor the progress, run the following command on your device: 
  ```
  $ sudo journalctl -fu aktualizr
  ```
- Make some change in the aktualizr package and follow steps 3 to 5 to create another version of root image
- You can now alternate between versions, download new versions, send faulty updates (with mistmatched content-hash or root-digest or no image found at the reported url in uptane manifest)
