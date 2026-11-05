# Android builds

Releases are organized by game and version.

The Mario + Duck Hunt + Track Meet web-core builds in `Mario-Duck-Hunt-Track-Meet/` are debug-signed by their CI workflow. They use the same application ID as NES Emulator but a different signer; they cannot update it in place or be installed alongside it. Debug signing may differ between CI runs, so versions may require uninstalling first, which can erase local saves. Back up saves before uninstalling.

NES Mario + Duck Hunt 1.3 also has a different signing key from 1.2 and cannot update it in place.
