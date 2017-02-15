#!/bin/sh


export PP_PROJECT_DIR=`dirname $PWD`
export PP_OUTPUT_DIR=$PP_PROJECT_DIR/output/${PP_BUILD_CONFIG,,}
export PP_CONFIG_DIR=$PP_PROJECT_DIR/config/${PP_BUILD_CONFIG,,}
export PP_PACKAGES_DIR=$PP_PROJECT_DIR/packages
export PP_THIRDPARTY_DIR=$PP_PROJECT_DIR/thirdparty
export PP_TOOLS_DIR=$PP_PROJECT_DIR/tools
export PP_PATCHES_DIR=$PP_PROJECT_DIR/patches
export PP_ROOTFS_OVERLAY_DIR=$PP_PROJECT_DIR/rootfs/overlay/${PP_BUILD_CONFIG,,}

export PP_BUILDROOT_DIR=`ls $PP_PACKAGES_DIR | grep buildroot`
export PP_BUILDROOT_DIR=$PP_THIRDPARTY_DIR/`basename $PP_BUILDROOT_DIR .tar.bz2`

export PP_REFSW_DIR=`ls $PP_PACKAGES_DIR | grep linux`
export PP_REFSW_DIR=$PP_THIRDPARTY_DIR/`basename $PP_REFSW_DIR .tar.bz2`
export PP_REFSW_PATCHES=$PP_PATCHES_DIR/refsw

export PP_KERNEL_DIR=$PP_REFSW_DIR/kernel

export PP_CLONER_DIR=`ls $PP_PACKAGES_DIR | grep cloner`
export PP_CLONER_DIR=$PP_TOOLS_DIR/`basename $PP_CLONER_DIR .tar.bz2`
export PP_REFSW_PATCHES=$PP_PATCHES_DIR/cloner

export PP_SRC_DIR=$PP_PROJECT_DIR/src

export PP_CROSS_COMPILER=mips-linux-gnu

export PP_TOOLCHAIN_DIR=$PP_REFSW_DIR/prebuilts/toolchains/mips-gcc472-glibc216/bin/

export PATH=$PATH:$PP_TOOLCHAIN_DIR