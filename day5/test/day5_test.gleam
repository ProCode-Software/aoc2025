import day5
import gleam/string
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

const input = "3-5
10-14
16-20
12-18

1
5
8
11
17
32"

// gleeunit test functions end in `_test`
pub fn part1_test() {
  let lines = string.split(input, on: "\n")
  let not_spoiled = day5.part1(lines)
  assert not_spoiled == 3
}
pub fn part2_test() {
  let lines = string.split(input, on: "\n")
  let all_not_spoiled = day5.part2(lines)
  assert all_not_spoiled == 14
}

pub fn part1_b_test() {
  let lines = string.split("1234-1238
2360-2400
3602-3611
8250-9000
123456-123460
2800-2805
9702-10800
1460-1580

1
2
2938476
1234
1236
1500
10000
8000
9752
123458
", on: "\n")
  let not_spoiled = day5.part1(lines)
  assert not_spoiled == 6
}
