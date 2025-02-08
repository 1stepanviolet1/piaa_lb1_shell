#!/bin/bash


call() {
    local funct=$1

    if ! declare -F "$funct" > /dev/null ; then
        echo "Bad function: $funct don't declare"
        exit 1
    fi

    declare -a args=()

    declare -i i=-2
    for arg in $@ ; do
        i+=1

        [ $i -eq -1 ] && continue

        args[$i]=$arg
    done

    local res
    res=$( eval "$funct ${args[@]}" )
    local exitcode=$?
    
    if [ $exitcode -ne 0 ] ; then
        echo "Bad call: $funct exitcode isn't 0"
        exit $exitcode
    fi

    echo $res
    return 0

}

