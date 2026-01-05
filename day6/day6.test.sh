#!/usr/bin/env bash
set -e
input=\
"123 328  51 64
 45 64  387 23
  6 98  215 314""
*   +   *   +  "

fails=0

source "$(dirname "$0")/day6.sh"

test_part1() {
    got=$(part1 <(echo "$input"))
    want=4277556
    if ((got != want)); then
        echo "part1 = $got, expected $want"
        ((fails++))
    else
        echo "part1 passed"
    fi
}
test_part2() {
    got=$(part2 <(echo "$input"))
    want=3263827
    if ((got != want)); then
        echo "part2 = $got, expected $want"
        ((fails++))
    else
        echo "part2 passed"
    fi
}

test_part1
test_part2

if [[ $fails -gt 0 ]]; then
    echo "$fails tests failed"
    exit 1
else
    echo "All tests passed"
    exit 0
fi
