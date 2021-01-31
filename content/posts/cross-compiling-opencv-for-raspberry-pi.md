---
title: "Cross Compiling OpenCV for the Raspberry Pi"
date: 2021-01-30T13:56:24-05:00
draft: true
---

resource: https://blog.kitware.com/cross-compiling-for-raspberry-pi/

## Installing crosstool-ng

https://crosstool-ng.github.io/

hit the downloads page

download, extract

`mkdir -p ~/.local/crosstool-ng`

`./configure -prefix=$HOME/.local/crosstool-ng`

had to install
- flex
- help2man
- gawk
- libncurses-dev

`make -j 8 && make install`

(other things surely installed)

## Creating a toolchain

`mkdir -p ~/RaspberryPi/staging`

`ct-ng menuconfig`

...options...

download kernel (`uname -r` on Pi gives 5.4.0) from https://cdn.kernel.org/pub/linux/kernel/v5.x/

`ct-ng build` (coffee...)