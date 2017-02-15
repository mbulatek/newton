#!/bin/bash

export PP_COMPONENT=U-BOOT

source common_functions.sh

source environment.sh


pushd $PP_SRC_DIR

make all

popd 