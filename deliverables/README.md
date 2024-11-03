## Deliverables

1. **The final contribution is made in the following branch/PR**: [PR n.123](https://github.com/uptane/aktualizr/pull/123)
2. To run the project, follow the steps mentioned in [setup.md](./setup.md)
3. Initial GSoC proposal can be found in [gsoc-proposal.pdf](./gsoc-proposal.pdf)
4. The project presentation is present in
5. Some scripts required to be integrated in [Torizon OS](https://www.toradex.com/operating-systems/torizon-os) image outside of the aktualizr repository for the implementation can be found in [scripts](../scripts/) directory


## Tests

1. Run without the server running
   ```
   Nov 02 11:52:08 verdin-imx8mm-14756500 aktualizr[1048]: got InstallStarted event
   Nov 02 11:52:08 verdin-imx8mm-14756500 aktualizr[1048]: Installing package using rauc package manager
   Nov 02 11:52:08 verdin-imx8mm-14756500 aktualizr[1048]: Target image URI: http://192.168.1.11:8080/v3.1/update-bundle-verdin-imx8mm.raucb
   Nov 02 11:52:08 verdin-imx8mm-14756500 aktualizr[1048]: Target Image sha256 digest: 7373c5f1f21b18369d63e81ff1e4a896060834871134041f4767cddb1371e8b0
   Nov 02 11:52:08 verdin-imx8mm-14756500 aktualizr[1048]: SHA256 hash written and file closed: /run/aktualizr/expected-digest
   Nov 02 11:52:08 verdin-imx8mm-14756500 aktualizr[1048]: Last Error:
   Nov 02 11:52:08 verdin-imx8mm-14756500 aktualizr[1048]: |-"Installing" (0%)
   Nov 02 11:52:08 verdin-imx8mm-14756500 aktualizr[1048]: | |-"Determining slot states" (0%)
   Nov 02 11:52:08 verdin-imx8mm-14756500 aktualizr[1048]: | |-"Determining slot states done." (10%)
   Nov 02 11:52:08 verdin-imx8mm-14756500 aktualizr[1048]: | |-"Checking bundle" (10%)
   Nov 02 11:52:13 verdin-imx8mm-14756500 aktualizr[1048]: | |-"Checking bundle failed." (20%)
   Nov 02 11:52:13 verdin-imx8mm-14756500 aktualizr[1048]: |-"Installing failed." (100%)
   Nov 02 11:52:13 verdin-imx8mm-14756500 aktualizr[1048]: Last Error: Failed to stream bundle http://192.168.1.11:8080/v3.1/update-bundle-verdin-imx8mm.raucb: failed to configure streaming: server not responding
   Nov 02 11:52:13 verdin-imx8mm-14756500 aktualizr[1048]: Installation did not complete successfully with status code: 1
   Nov 02 11:52:14 verdin-imx8mm-14756500 aktualizr[1048]: got InstallTargetComplete event
   Nov 02 11:52:14 verdin-imx8mm-14756500 aktualizr[1048]: got AllInstallsComplete event with status: "verdin-imx8mm-rauc:INSTALL_FAILED":4
   Nov 02 11:52:14 verdin-imx8mm-14756500 aktualizr[1048]: pending for ecu: false
   Nov 02 11:52:14 verdin-imx8mm-14756500 aktualizr[1048]: config.uptane.force install _completion: true
   Nov 02 11:52:14 verdin-imx8mm-14756500 aktualizr[1048]: got PutManifestComplete event
   ```
2. Wrong URL path:
   ```
   Nov 02 11:48:11 verdin-imx8mm-14756500 aktualizr[1048]: got InstallStarted event
   Nov 02 11:48:11 verdin-imx8mm-14756500 aktualizr[1048]: Installing package using rauc package manager
   Nov 02 11:48:11 verdin-imx8mm-14756500 aktualizr[1048]: Target image URI: http://192.168.29.3:8080/update-bundle-verdin-imx8mm. raucb
   Nov 02 11:48:11 verdin-imx8mm-14756500 aktualizr[1048]: Target Image sha256 digest: ce9c33ce86e1d261f1f1d761b0a3d6aa873fd198d6d54b106beaac266e511d8a
   Nov 02 11:48:11 verdin-imx8mm-14756500 aktualizr[1048]: SHA256 hash written and file closed: /run/aktualizr/expected-digest
   Nov @2 11:48:11 verdin-imx8mm-14756500 aktualizr[1048]: Last Error
   Nov 02 11:48:11 verdin-imx8mm-14756500 aktualizr[1048]: |-"Installing" (0%)
   Nov 02 11:48:11 verdin-imx8mm-14756500 aktualizr[1048]: | |-"Determining slot states" (0%)
   Nov 02 11:48:11 verdin-imx8mm-14756500 aktualizr[1048]: | |-"Determining slot states done." (10%)
   Nov 02 11:48:11 verdin-imx8mm-14756500 aktualizr[1048]: | |-"Checking bundle" (10%)
   Nov 02 11:50:16 verdin-imx8mm-14756500 aktualizr[1048]: | |-"Checking bundle failed." (20%)
   Nov 02 11:50:16 verdin-imx8mm-14756500 aktualizr[1048]: |-"Installing failed." (100%)
   Nov 02 11:50:16 verdin-imx8mm-14756500 aktualizr[1048]: Last Error: Failed to stream bundle http://192.168.29.3:8080/update-bundle-verdin-imx8mm.raucb: failed to configure streaming: server not responding
   Nov 02 11:50:16 verdin-imx8mm-14756500 aktualizr[1048]: Installation did not complete successfully with status code: 1
   Nov 02 11:50:16 verdin-imx8mm-14756500 aktualizr[1048]: got InstallTargetComplete event
   Nov 02 11:50:16 verdin-imx8mm-14756500 aktualizr[1048]: got AllInstallsComplete event with status: "verdin-imx8mm-rauc:INSTALL_FAILED":4
   Nov 02 11:50:16 verdin-imx8mm-14756500 aktualizr[1048]: pending for ecu: false
   Nov 02 11:50:16 verdin-imx8mm-14756500 aktualizr[1048]: config.uptane.force install_completion: true
   Nov 02 11:50:17 verdin-imx8mm-14756500 aktualizr[1048]: got PutManifestComplete event
   ```
3. Wrong image digest:
   ```
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: got InstallStarted event
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: Installing package using rauc package manager
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: Target image URI: http://192.168.1.11:8080/v3.0/update-bundle-verdin-imx8mm. raucb
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: Target Image sha256 digest: 2929fcc9a32949d96f23bb1f98ee87d01460728a7dea7ec5e740a5e462a6ac48
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: SHA256 hash written and file closed: /run/aktualizr/expected-digest
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: Last Error:
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |-"Installing" (0%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |  |-"Determining slot states" (0%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |  |-"Determining slot states done." (10%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |  |-"Checking bundle" (10%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |  |  |-"Verifying signature" (10%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |  |  |-"Verifying signature done." (20%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |  |-"Checking bundle done." (20%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |  |-"Checking manifest contents" (20%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |  |-"Checking manifest contents done." (30%)
   block nbd@: NBD DISCONNECT
   block nbd@: Disconnected due to user request.
   block nbd@: shutting down sockets
   blk_update_request: I/0 error, dev nbd@, sector 258704 op 0x0:(READ) flags 0x80700 phys seg 1 prio class 0
   blk_update_request: I/O error, dev nbd@, sector 258704 op 0x0:(READ) flags 0x0 phys seg 1 prio class 0
   Buffer I/O error on dev nbd@, logical block 32338, async page read
   block nbd@: NBD DISCONNECT
   block nbd@: Send disconnect failed -32
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |  |-"Determining target install group" (30%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |  |-"Determining target install group done." (40%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: |-"Installing failed." (100%)
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: Last Error: Pre-install handler error: Child process exited with code 1
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: Installation did not complete successfully with status code: 1
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: got InstallTargetComplete event
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: got AllInstallsComplete event with status: "verdin-imx8mm-rauc:INSTALL_FAILED":4
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: pending for ecu: false
   Nov 02 11:59:19 verdin-imx8mm-14756500 aktualizr[1048]: config.uptane.force install _completion: true
   Nov 02 11:59:20 verdin-imx8mm-14756500 aktualizr[1048]: got PutManifestComplete event
   ```
4. Wrong content hash:
   ```
   Nov 02 12:02:07 verdin-imx8mm-14756500 aktualizr[1049]: current hash: 2bb84c40e40062a88a8991e77fdcf26a442ffc8697ceee83eabc0fa9ab9d6a59
   Nov 02 12:02:07 verdin-imx8mm-14756500 aktualizr[1049]: Expected to boot 2bb84c40e40062a88a8991e77fdcf26a442ffc8697ceee83eabc0fa9ab9d6a50 but found 2bb84c40e40062a88a8991e77fdcf26a442ffc8697ceee83eabc0fa9ab9d6a59. The system may have been rolled back.
   Nov 02 12:02:07 verdin-imx8mm-14756500 aktualizr[1049]: verdin-imx8mm-14756500 aktualizr Current versions in storage and reported by RAUC do not match
   Nov 02 12:02:07 verdin-imx8mm-14756500 aktualizr[1049]: curl error 60 (http code 0): SSL peer certificate or SSH remote key was not OK
   Nov 02 12:02:07 verdin-imx8mm-14756500 aktualizr[1049]: curl error 60 (http code 0): SSL peer certificate or SSH remote key was not OK
   Nov 02 12:02:09 verdin-imx8mm-14756500 aktualizr[1049]: curl error 60 (http code 0): SSL peer certificate or SSH remote key was not OK
   Nov 02 12:02:09 verdin-imx8mm-14756500 aktualizr[1049]: curl error 60 (http code 0): SSL peer certificate or SSH remote key was not OK
   Nov 02 12:02:11 verdin-imx8mm-14756500 aktualizr[1049]: curl error 60 (http code 0): SSL peer certificate or SSH remote key was not OK
   Nov 02 12:02:11 verdin-imx8mm-14756500 aktualizr[1049]: Failed to post update events: 60 SSL peer certificate or SSH remote key was not OK HTTP 0
   Nov 02 12:02:11 verdin-imx8mm-14756500 aktualizr[1049]: curl error 60 (http code 0): SSL peer certificate or SSH remote key was not OK
   Nov 02 12:02:11 verdin-imx8mm-14756500 aktualizr[1049]: Put manifest request failed: 60 SSL peer certificate or SSH remote key was not OK HTTP 0
   Nov 02 12:02:11 verdin-imx8mm-14756500 aktualizr[1049]: Primary ECU serial: 5cb19c3lafdda6f49a7e4e9f01c77f6c03a4400db405ee31293837b156af7a18 with hardware ID: verdin-imx8mm-rauc
   Nov 02 12:02:11 verdin-imx8mm-14756500 aktualizr[1049]: Device ID: 30a921da-43df-47fb-9dc0-5ed7227893T0
   Nov 02 12:02:11 verdin-imx8mm-14756500 aktualizr[1049]: Device Gateway URL: https://ota-ce.torizon.io
   Nov 02 12:02:11 verdin-imx8mm-14756500 aktualizr[1049]: Certificate subject: CN=30a921da-43df-47fb-9dc0-5ed7227893f0
   Nov 02 12:02:11 verdin-imx8mm-14756500 aktualizr[1049]: Certificate issuer: CN=ota-devices-CA
   Nov 02 12:02:11 verdin-imx8mm-14756500 aktualizr[1049]: Certificate valid from: Nov 1 12:50:23 2024 GMT until: Nov 1 12:50:23 2124 GMT
   Nov 02 12:02:13 verdin-imx8mm-14756500 aktualizr[1049]: got SendDeviceDataComplete event
   Nov 02 12:02:13 verdin-imx8mm-14756500 aktualizr[1049]: Current versions in storage and reported by RAUC do not match
   Nov 02 12:02:14 verdin-imx8mm-14756500 aktualizr[1049]: Connectivity is restored.
   [ 41.806038] audit: type=1334 audit(1730548939.090:13): prog-id=10 op=UNLOAD
   [ 41.813042] audit: type=1334 audit(1730548939.090:14): prog-id=9 op=UNLOAD
   Nov 02 12:02:25 verdin-imx8mm-14756500 aktualizr[1049]: Current versions in storage and reported by RAUC do not match
   ```
