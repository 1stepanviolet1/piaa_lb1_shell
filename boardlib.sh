#!/bin/bash

source utils.sh

declare -i N=0


get_index() {
    [ $N -eq 0 ] && return 1
    echo $(($1*N + $2))
}


get_coords() {
    [ $N -eq 0 ] && return 1
    declare -i j=$(($1 % N))
    declare -i i=$(($1 / N))
    echo "$i $j"
}


print_board() {
    [ $N -eq 0 ] && return 1

    declare -a arr=( $@ )
    local row=""
    local sep=""
    declare -i index=0

    for i in $( seq 0 $((N-1)) ) ; do
        row=""

        for j in $( seq 0 $((N-1)) ) ; do
            sep="\t"
            [ -z "$row" ] && sep=""

            row+=$sep
            row+=${arr[$( get_index $i $j )]}
        done

        echo -e $row | expand -t 4
    
    done
    
}


get_board() {
    [ $N -eq 0 ] && return 1

    declare -a arr
    local value=$1

    for i in $( seq 0 $((N-1)) ); do

        for j in $( seq 0 $((N-1)) ); do
            arr[$( get_index $i $j )]=$value
        done

    done

    echo ${arr[@]}

}


get_zero_board() {
    call get_board 0
    echo ${result[@]}
}


is_valid_cell() {
    [ $N -eq 0 ] && return 1

    declare -i x=$1
    declare -i y=$2
    declare -i n=$3

    if [ $((x+n)) -gt $N ] || [ $((y+n)) -gt $N ] ; then
        echo 0
        return 0
    fi

    declare -a board=( ${!4} )

    for i in $( seq $x $((x+n-1)) ) ; do
        
        for j in $( seq $y $((y+n-1)) ) ; do
            if [ ${board[$( get_index $i $j )]} -ne 0 ] ; then
                echo 0
                return 0
            fi
        done

    done

    echo 1

}


set_cells_from_square() {
    declare -i x=$1
    declare -i y=$2
    declare -i n=$3

    declare -i val=$4

    declare -a board=(${!5})

    for i in $( seq $x $((x+n-1)) ) ; do
        
        for j in $( seq $y $((y+n-1)) ) ; do
            board[$( get_index $i $j )]=$val
        done

    done

    echo ${board[@]}

}


place_square() {
    call set_cells_from_square $1 $2 $3 1 $4
    echo ${result[@]}
}


remove_square() {
    call set_cells_from_square $1 $2 $3 0 $4
    echo ${result[@]}
}


find_empty_cell() {
    [ $N -eq 0 ] && return 1

    declare -a board=( ${!1} )

    for i in $( seq 0 $((N-1)) ) ; do
        
        for j in $( seq 0 $((N-1)) ) ; do
            if [ ${board[$( get_index $i $j )]} -eq 0 ] ; then
                echo "$i $j"
                return 0
            fi
        done

    done

    echo "nil"

}

