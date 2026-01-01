package main

import (
	_ "embed"
	"fmt"
	"strconv"
	"strings"
)

//go:embed input.txt
var input string

func main() {
	n := Part1(input)
	fmt.Printf("Invalid: %d\n", n)
	n2 := Part2(input)
	fmt.Printf("Invalid 2: %d\n", n2)
}

func Part1(input string) (allInvalid int) {
	input = strings.TrimSpace(input)
	for rang := range strings.SplitSeq(input, ",") {
		both := strings.Split(rang, "-")
		startS, endS := both[0], both[1]
		start, err1 := strconv.Atoi(startS)
		end, err2 := strconv.Atoi(endS)
		if err1 != nil {
			panic(err1)
		} else if err2 != nil {
			panic(err2)
		}
		for i := start; i <= end; i++ {
			str := strconv.Itoa(i)
			part1, part2 := str[:len(str)/2], str[len(str)/2:]
			if part1 == part2 {
				allInvalid += i
			}
		}
	}
	return
}

func Part2(input string) (allInvalid int) {
	for rang := range strings.SplitSeq(input, ",") {
		rang = strings.TrimSpace(rang)
		both := strings.Split(rang, "-")
		startS, endS := both[0], both[1]
		start, err1 := strconv.Atoi(startS)
		end, err2 := strconv.Atoi(endS)
		if err1 != nil {
			panic(err1)
		} else if err2 != nil {
			panic(err2)
		}
	numberInRange:
		for i := start; i <= end; i++ {
			str := strconv.Itoa(i)
			half := len(str) / 2
			j := half
			// 12311231
			// 12341234
			// 112112
			// 1212121212
		checkRepeating:
			for j >= 1 {
				if len(str)%j != 0 {
					// Next lowest factor
					for j > 0 && len(str)%j != 0 {
						j--
					}
					continue checkRepeating
				}
				// Is a factor
				if isRepeating(str, str[:j]) {
					allInvalid += i
					continue numberInRange
				}
				j--
			}
		}
	}
	return
}

func isRepeating(s, sub string) bool {
	lns, lnsub := len(s), len(sub)
	if lns%lnsub != 0 {
		return false
	}
	for k := 0; k+lnsub <= lns; k += lnsub {
		if s[k:k+lnsub] != sub {
			return false
		}
	}
	return true
}
