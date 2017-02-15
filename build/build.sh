#!/bin/bash

export PP_COMPONENT=PROJECT

source common_functions.sh

parse_arguments $1 $2 $3 $4

source environment.sh

print_environment



############ Begin of the script ############

check_for_command_exist tune2fs



mkdir -p $PP_OUTPUT_DIR

# extract refsw package if necessary
if [ -d $PP_REFSW_DIR ] ; then
	print_info "Refsw dir already exist, skipping extract"
else
	extract_thirdparty linux
fi

# extract buildroot package if necessary
if [ -d $PP_BUILDROOT_DIR ] ; then
	print_info "Buildroot dir already exist, skipping extract"
else
	extract_thirdparty buildroot
fi

# extract cloner package if necessary
if [ -d $PP_CLONER_DIR ] ; then
	print_info "USBCloner dir already exist, skipping extract"
else
	extract_tool cloner
fi



# Build refsw
print_info "Building refsw"
pushd $PP_REFSW_DIR

source build/envsetup.sh
lunch

make
if [ $? -ne 0 ] ; then
	print_error "Failed to build refsw!!!"
	exit -1
fi

cp -f out/product/Newton2Plus/image/uImage $PP_OUTPUT_DIR
cp -f out/product/Newton2Plus/image/u-boot-with-spl-mbr-gpt.bin $PP_OUTPUT_DIR

popd


# Build buildroot
print_info "Building buildroot"


# Copy downloaded packages
print_info "Copying downloaded buildroot packages"
mkdir $PP_BUILDROOT_DIR/dl
cp -f $PP_PACKAGES_DIR/dl/* $PP_BUILDROOT_DIR/dl
if [ $? -ne 0 ] ; then
	print_error "Failed to copy downloaded buildroot packages!!!"
	exit -1
fi


# TODO - hack for missing kernel headers in toolchain, FIXME
print_info "Hacking missing kernel headers" 
cp -f $PP_REFSW_DIR/kernel/include/generated/uapi/linux/version.h $PP_REFSW_DIR/prebuilts/toolchains/mips-gcc472-glibc216/mips-linux-gnu/libc/usr/include/linux
if [ $? -ne 0 ] ; then
	print_error "Failed to hack kernel headers!!!"
	exit -1
fi

pushd $PP_BUILDROOT_DIR

apply_config buildroot

make PP_PROJECT_DIR=$PP_PROJECT_DIR PP_REFSW_DIR=$PP_REFSW_DIR PP_ROOTFS_OVERLAY_DIR=$PP_ROOTFS_OVERLAY_DIR
if [ $? -ne 0 ] ; then
	print_error "Failed to build buildroot!!!"
	exit -1
fi

cp -f output/images/rootfs.ext2 $PP_OUTPUT_DIR
tune2fs -O extents,uninit_bg,dir_index,has_journal $PP_OUTPUT_DIR/rootfs.ext2
mv -f $PP_OUTPUT_DIR/rootfs.ext2 $PP_OUTPUT_DIR/rootfs.ext4

popd

