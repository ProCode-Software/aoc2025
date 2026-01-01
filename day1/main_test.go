package main

import "testing"

func TestCalc(t *testing.T) {
	testCases := []struct {
		input string
		pwd, pwd2   int
	}{
		{`L68
L30
R48
L5
R60
L55
L1
L99
R14
L82`, 3, 6},
		// {"L10\nL20\nL50", 0, 1},
		// {"L10\nL20\nL50\nR60\nR70", 0, 3},
	}
	for _, tt := range testCases {
		t.Run("Part1", func(t *testing.T) {
			t.SkipNow()
			pwd := Calc([]byte(tt.input))
			if pwd != tt.pwd {
				t.Errorf("expected %d as password, got %d", tt.pwd, pwd)
			}
		})
		t.Run("Part2", func(t *testing.T) {
			pwd2 := Calc2([]byte(tt.input))
			if pwd2 != tt.pwd2 {
				t.Errorf("expected %d as password, got %d", tt.pwd2, pwd2)
			}
		})
	}
}
