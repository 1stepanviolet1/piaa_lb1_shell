#!/bin/bash

source utils.sh
source matrixlib.sh

declare -i N=5
# read -p "Enter arr size: " N


declare -a arr=$( call get_zero_arr )
echo "Full zero arr N=5"
print_arr ${arr[@]} # TODO: bad res

echo "-----------------"

arr=$( call place_square 0 0 4 arr[@] )
echo "Place square N=4"
print_arr ${arr[@]}

echo "-----------------"

arr=$( call remove_square 1 1 2 arr[@] )
echo "Remove square N=2"
print_arr ${arr[@]}


