#!/bin/bash

result="default"

call() {
    local funct=$1

    if ! declare -F "$funct" > /dev/null ; then
        echo "Bad function: $funct don't declare"
        exit 1
    fi

    declare -a args

    declare -i i=-2
    for arg in $@ ; do
        i+=1
        [ $i -eq -1 ] && continue

        args[$i]=$arg
    done

    declare -g result
    result=( $( eval "$funct ${args[@]}" ) )
    declare -i exitcode=$?
    
    if [ $exitcode -ne 0 ] ; then
        echo "Bad call: $funct exitcode is $exitcode"
        exit $exitcode
    fi

}


len() {
    echo $#
}


min() {
    declare -i min_val=$1

    for el in $@ ; do
        [ $el -lt $min_val ] && min_val=$el
    done

    echo $min_val

}


copy_associative_arr() {
    local -n destination=$1
    local -n source=$2

    for key in ${!source[@]}; do
        destination[$key]=${source[$key]}
    done

}

print_associative_arr() {
    local -n arr=$1

    for key in "${!arr[@]}"; do
        echo "(${arr[$key]})"
    done

}
