#!/bin/bash

source utils.sh

declare -i N=0


get_index() {
    if [ $N -eq 0 ] ; then
        return 1
    fi

    echo $(($1*N + $2))

}


print_arr() {
    if [ $N -eq 0 ] ; then
        return 1
    fi

    declare -a arr=($@)
    local row=""
    local sep=""
    declare -i index=0

    for i in $( seq 0 $((N-1)) ) ; do
        row=""

        for j in $( seq 0 $((N-1)) ) ; do
            sep="\t"
            if [ -z "$row" ] ; then
                sep=""
            fi

            row+=$sep
            row+=${arr[$( get_index $i $j )]}
        done

        echo -e $row | expand -t 4
    
    done
    
}


get_arr() {
    if [ $N -eq 0 ] ; then
        return 1
    fi

    declare -a arr
    local value=$1

    for i in $( seq 0 $((N-1)) ); do

        for j in $( seq 0 $((N-1)) ); do
            arr[$( get_index $i $j )]=$value
        done

    done

    echo ${arr[@]}

}


get_zero_arr() {
    local res=$( call get_arr 0 )
    echo ${res[@]}

}


is_valid() {
    if [ $N -eq 0 ] ; then
        return 1
    fi

    declare -i x=$1
    declare -i y=$2
    declare -i w=$3

    if [ $((x+w)) -gt $N ] || [ $((y+w)) -gt $N ] ; then
        echo 0
    fi

    declare -a board=(${!4})

    for i in $( seq $x $((x+w-1)) ) ; do
        
        for j in $( seq $y $((y+w-1)) ) ; do
            if [ ${board[$( get_index $i $j )]} -ne 0 ] ; then
                echo 0
            fi
        done

    done

    echo 1

}


set_cells_from_square() {
    declare -i x=$1
    declare -i y=$2
    declare -i w=$3

    declare -i val=$4

    declare -a board=(${!5})

    for i in $( seq $x $((x+w-1)) ) ; do
        
        for j in $( seq $y $((y+w-1)) ) ; do
            board[$( get_index $i $j )]=$val
        done

    done

    echo ${board[@]}

}


place_square() {
    local res=$( call set_cells_from_square $1 $2 $3 1 $4 ) 
    echo ${res[@]}
}


remove_square() {
    local res=$( call set_cells_from_square $1 $2 $3 0 $4 )
    echo ${res[@]}
}


