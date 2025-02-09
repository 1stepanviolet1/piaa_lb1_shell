#!/bin/bash

source utils.sh

source boardlib.sh
read -p "Enter board side: " N

declare -a board
call get_zero_board
board=( ${result[@]} )

declare -i min_cnt_squares=99999999999999
declare -i curr_cnt_squares=0
declare -A min_squares
declare -A curr_squares

best_board_filling() {
    
    [ $curr_cnt_squares -ge $min_cnt_squares ] && return 0

    call find_empty_cell board[@]
    if [ "$result" = "nil" ] ; then
        if [ $curr_cnt_squares -lt $min_cnt_squares ] ; then 
            min_cnt_squares=$curr_cnt_squares
            copy_associative_arr min_squares curr_squares
        fi

        return 0

    fi

    local x=${result[0]}
    local y=${result[1]}

    call min $((N-x)) $((N-y))
    declare -i side
    for (( side=$result; side > 0; side-- )) ; do
        [ $side -eq $N ] && continue

        call is_valid_cell $x $y $side board[@]
        [ $result -eq 0 ] && continue

        call place_square $x $y $side board[@]
        board=( ${result[@]} )

        curr_squares[$curr_cnt_squares]="$((x+1)) $((y+1)) $side"
        curr_cnt_squares=$((curr_cnt_squares+1))

        best_board_filling

        call remove_square $x $y $side board[@]
        board=( ${result[@]} )

        curr_cnt_squares=$((curr_cnt_squares-1))
        curr_squares[$curr_cnt_squares]=""
    done

}

best_board_filling

echo $min_cnt_squares

for k in $( seq 0 $((min_cnt_squares-1)) ); do
    echo ${min_squares[$k]}
done
