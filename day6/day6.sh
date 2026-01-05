#!/usr/bin/env bash
set -e
grand_total=0

# Create the matrix
make_matrix() {
    mapfile -t lines <"$1"
    num_lines=${#lines[@]}
    local line i=0
    for line in "${lines[@]}"; do
        local col
        declare -n ref="line_$i"
        IFS=' ' read -r -a line_items <<<"$line"
        for col in "${line_items[@]}"; do
            ref+=("$col")
        done
        ((i++))
    done
}

calc() {
    local col_i=0 op
    local -n op_line="line_$((num_lines - 1))"
    # Each column
    for op in "${op_line[@]}"; do
        # Each row
        local col_total=0
        [[ $op == "*" ]] && col_total=1
        for ((line_i = 0; line_i < num_lines - 1; line_i++)); do
            local -n line_array=line_"$line_i"
            local item=${line_array[$col_i]}
            col_total=$(bc <<<"$col_total $op $item")
        done
        ((grand_total += col_total))
        ((col_i++))
    done
}

part1() {
    grand_total=0
    make_matrix "$1"
    calc
    echo "$grand_total"
}

# Part 2
# =================

make_col_lengths() {
    # Read lines
    mapfile -t lines <"$1"
    num_lines=${#lines[@]}
    # Make column lengths
    local str_op_line=${lines[num_lines - 1]}
    col_lens=()
    local i curr_len=1
    # start at 1 to skip first operator
    for ((i = 1; i < ${#str_op_line}; i++)); do
        char=${str_op_line:i:1}
        if [[ $char == " " ]]; then
            ((curr_len++))
        else
            col_lens+=("$((curr_len - 1))")
            ((curr_len = 1))
        fi
    done
    col_lens+=("$curr_len")

    # Read columns
    local line line_i=0
    for line in "${lines[@]}"; do
        local col_i=0 offset
        local -n ref="line_$line_i"
        for ((offset = 0; offset < ${#line}; col_i++)); do
            local col_len=${col_lens[$col_i]}
            local col=${line:$offset:$col_len}
            ref+=("$col")
            ((offset += col_len + 1))
        done
        ((line_i++))
    done
}

part2_calc() {
    local col_i=0 op
    # Each column
    for op in "${op_line[@]}"; do
        local -a items=()
        local line_i
        # Collect items
        for ((line_i = 0; line_i < num_lines - 1; line_i++)); do
            local -n line_array=line_"$line_i"
            local item=${line_array[$col_i]}
            items+=("$item")
        done
        local col_len=${col_lens[$col_i]}
        # Map items
        # Loop $col_len times
        local digit_i
        local -a new_items=()
        for ((digit_i = 0; digit_i < col_len; digit_i++)); do
            local item new_num=""
            # Each i'th character in each item
            for item in "${items[@]}"; do
                local digit=${item:$digit_i:1}
                [[ $digit != " " ]] && new_num+=$digit
            done
            new_items+=("$new_num")
        done
        # Solve items
        local col_total=0
        [[ ${op:0:1} == "*" ]] && col_total=1
        for item in "${new_items[@]}"; do
            col_total=$(bc <<<"$col_total $op $item")
        done
        ((grand_total += col_total))
        ((col_i++))
    done
}

part2() {
    grand_total=0
    make_col_lengths "$1"
    declare -n op_line="line_$((num_lines - 1))"
    part2_calc
    echo "$grand_total"
}

if [[ ${#BASH_SOURCE[@]} -eq 1 ]]; then
    echo "Part 1: $(part1 "$(dirname "$0")/input.txt")"
    echo "Part 2: $(part2 "$(dirname "$0")/input.txt")"
fi
