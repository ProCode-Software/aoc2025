package main

import (
	"bufio"
	"bytes"
	_ "embed"
	"fmt"
	"strconv"
)

//go:embed input.txt
var input []byte

func main() {
	pwd := Calc(input)
	fmt.Println("Password:", pwd)
	pwd = Calc2(input)
	fmt.Println("Second Password:", pwd)
}

func Calc(input []byte) (pwd int) {
	dial := 50
	scanner := bufio.NewScanner(bytes.NewReader(input))
	for scanner.Scan() {
		line := scanner.Text() // Ex: L52
		if line == "" {
			continue
		}
		num, err := strconv.Atoi(line[1:])
		if err != nil {
			panic(err)
		}
		switch dir := line[0]; dir {
		case 'L':
			dial = (dial - num) % 100
		case 'R':
			dial = (dial + num) % 100
		default:
			panic("invalid direction: " + string(dir))
		}
		if dial == 0 {
			pwd++
		}
	}
	if err := scanner.Err(); err != nil {
		panic(err)
	}
	return
}

func Calc2(input []byte) (pwd int) {
	dial := 50
	scanner := bufio.NewScanner(bytes.NewReader(input))
	for scanner.Scan() {
		line := scanner.Text() // Ex: L52
		if line == "" {
			continue
		}
		num, err := strconv.Atoi(line[1:])
		if err != nil {
			panic(err)
		}
		var op int
		switch dir := line[0]; dir {
		case 'L':
			op = -1
		case 'R':
			op = +1
		default:
			panic("invalid direction: " + string(dir))
		}
		for range num {
			dial += op
			if dial%100 == 0 {
				pwd++
			}
		}
	}
	if err := scanner.Err(); err != nil {
		panic(err)
	}
	return
}
