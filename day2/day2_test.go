package main

import "testing"

func TestPart2(t *testing.T) {
	tc := `11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
1698522-1698528,446443-446449,38593856-38593862,565653-565659,
824824821-824824827,2121212118-2121212124`
	const exp = 4174379265
	if got := Part2(tc); got != exp {
		t.Errorf("expected %d, got %d", exp, got)
	}
}
