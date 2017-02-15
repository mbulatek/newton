#!/bin/bash


function parse_arguments {
	#	if [ $# -ne 1 ] ; then
		#	print_usage
		#exit -1
	#fi
	
	if [ "$1" == "debug" ] ; then
		export PP_BUILD_CONFIG=DEBUG
	elif [ "$1" == "release" ] ; then
		export PP_BUILD_CONFIG=RELEASE
	else
		print_error "Unknown 1st parameter: \"$1\""
		print_usage
		exit -1
	fi
}


function print_usage {
	echo -e "\nUsage:"
	echo -e "\t" `basename "$0"` "<debug|release>\n"
}

function print_info {
	echo -e "\033[1;33mBUILD_INFO: $1\033[0m"
}

function print_warning {
	echo -e "\033[0;33mBUILD_WARNING: $1\033[0m"
}

function print_error {
	echo -e "\033[0;31mBUILD_ERROR: $1\033[0m"
}

function print_environment {
	echo -e "\033[1;33m"			# for yellow color
	echo -e "\n=========================== BUILD $PP_COMPONENT ==========================="
	echo -e "Build configuration:\t$PP_BUILD_CONFIG"
	echo -e "Project directory:\t$PP_PROJECT_DIR"
	echo -e "Config directory:\t$PP_CONFIG_DIR"
	echo -e "Output directory:\t$PP_OUTPUT_DIR\n"
	echo -e "Buildroot directory:\t$PP_BUILDROOT_DIR"
	echo -e "Refsw directory:\t$PP_REFSW_DIR"
	echo -e "USBCloner directory:\t$PP_CLONER_DIR"
		echo -e "=====================================================================\n"
	echo -e "\033[0m"				# for no color
}

function check_for_command_exist {
	which $1 > /dev/null

	if [ $? -ne 0 ] ; then
		print_error "$1 command do not exist, please install"
		exit -1
	fi
}


function extract_thirdparty {
	print_info "Extracting $1..."
	file_name=`ls $PP_PACKAGES_DIR | grep $1`
	
	tar -xjpf $PP_PACKAGES_DIR/$file_name -C $PP_THIRDPARTY_DIR
	
	if [ $? -ne 0 ] ; then
		print_error "Extracting failed"
		exit -1
	else
		print_info "Extracting done"
	fi
}


function extract_tool {
	print_info "Extracting $1..."
	file_name=`ls $PP_PACKAGES_DIR | grep $1`
	
	tar -xjpf $PP_PACKAGES_DIR/$file_name -C $PP_TOOLS_DIR

		if [ $? -ne 0 ] ; then
		print_error "Extracting failed"
		exit -1
	else
		print_info "Extracting done"
	fi
}


function apply_config {
	src_file=$PP_CONFIG_DIR/`ls $PP_CONFIG_DIR | grep $1`
	dest_file=$PP_BUILDROOT_DIR/.config
	
	print_info "Applying config for $1: $src_file ---> $dest_file"
	cp -f $src_file $dest_file
}


function apply_patches {
	src_dir=$PP_PATCHES_DIR/`ls $PP_PATCHES_DIR | grep $1`
	dest_dir=$PP_THIRDPARTY_DIR/`ls $PP_THIRDPARTY_DIR | grep $1`
	
	print_info "Applying patch for $1: $src_dir ---> $dest_dir"
	cp -rf $src_dir $dest_dir
}


export parse_arguments
export print_usage
export print_info
export print_warning
export print_error
export print_environment
export check_for_command_exist
export extract_thirdparty
export extract_tool
export apply_config
export apply_patches
