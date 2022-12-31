#!/bin/bash


sudo apt-get install ninja-build

sudo apt-get install git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev libgtk-3-dev libsdl2-dev libspice-protocol-dev libspice-server-dev libusb-dev libusbredirparser-dev libusb-1.0-0-dev libnuma-dev libcap-ng-dev libattr1-dev libaio-dev
sudo apt install libgles2-mesa-dev libxcb-composite0-dev libxcursor-dev   libcairo2-dev libgbm-dev libpam0g-dev
sudo apt install xutils-dev libgl1-mesa-dev
sudo apt install libepoxy-dev
sudo apt install libepoxy-dev libepoxy0 gdm3 libgdm-dev libgdm1
sudo apt-get install libusb-dev

export LDD_ROOT=/home/xuqnqn/work/ldd_root
export KERNELDIR=$LDD_ROOT/kernels/linux-5.10.4
export PATH=$LDD_ROOT/bin:$PATH
export PATH=$LDD_ROOT/bin/bin:$PATH
export INSTALL_DIR=$LDD_ROOT/bin
export CONFIG_DIR=$INSTALL_DIR/etc

## compile arm64 qemu-system-aarch64
export TARGET_LIST="aarch64-softmmu,arm-softmmu"
../configure     --prefix=$INSTALL_DIR     --sysconfdir=$CONFIG_DIR     --target-list=$TARGET_LIST     --enable-virtfs     --enable-debug     --extra-cflags="-g3"     --extra-ldflags="-g3"     --disable-strip     --disable-docs
make -j4
make install

cd $INSTALL_DIR
ln -s bin/qemu-system-aarch64 qemu



## compile arm64 kernel
cd $KERNELDIR
make ARCH=arm64 defconfig
make ARCH=arm64 menuconfig
make -j4 ARCH=arm64 Image


## Install busybox
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
make defconfig
make menuconfig # choose static build option
make -j4
#make install busybox, will generate _install dir
bin/busybox --install bin
bin/busybox --install sbin

