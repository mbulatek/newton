#!/bin/bash

export PP_COMPONENT=KERNEL

source common_functions.sh

parse_arguments $1 $2 $3 $4

source environment.sh

print_environment