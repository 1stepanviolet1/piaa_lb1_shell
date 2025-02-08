#!/bin/bash

source utils.sh


func() {
    declare -a args=(${!1})

    args[1]=$2

    echo "${args[@]}"
    return 0

}


declare -a arr=(1 2 3 4 5)

# res=$( eval "func arr[@]" )
# echo "exitcode: $?"
# echo "res: $res"


res=$( call func arr[@] 12 )
echo "res: $res"
