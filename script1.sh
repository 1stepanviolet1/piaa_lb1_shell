#!/bin/bash

source utils.sh
source matrixlib.sh

declare -i N=5
# read -p "Enter arr size: " N


declare -a arr=$( call get_zero_arr )

call print_arr ${arr[@]} # TODO: bad res

echo "-----------------"

arr=$( call place_square 0 0 3 arr[@] )

call print_arr ${arr[@]} # TODO: bad res
