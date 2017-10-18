Firmware Update without Windows installed
=========================================

Download all necessary firmware updates from lenovo.com

Install woeusb[3] (archlinux: aur/woeusb-git)

Load pre-built image from this[2] website[2] (or build it yourself :-)

Use woeusb to write the image to a 8GB+ Stick/Whatever with:

```bash
sudo woeusb -v --device /path/to/winpe.iso /dev/disk/my/stick
```

Mount the stick and extract all firmware images there.

Boot your computer from this stick (works with/without EFI CSM)

Enjoy all the WinPE glory and clickiness. I could successfully install all
updates for my Thinkpad x260. Beware that a minimal Windows PE image may not work
with the firmware update mechanism your vendor is using. For example,
i could not install the TPM Chip firmware update for the x260 with just the basic
Windows PE, but only the fullblown Desktop i referenced above.

Win PE Prebuilt (current: 2017-10-18): 

[1]: https://cloudnull.io/2017/07/x1-firmware-without-windows/
[2]: https://toolslib.net/downloads/viewdownload/322-winpese-x64-14393/
[3]: https://github.com/slacka/WoeUSB
