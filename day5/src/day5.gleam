import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

type Range {
  Range(from: Int, to: Int)
}

pub fn main() -> Nil {
  let assert Ok(file) = simplifile.read(from: "./input.txt")
  let lines = string.split(file, on: "\n")
  // Part 1
  let not_spoiled = part1(lines)
  echo not_spoiled
  io.println("Part 1 - Not spoiled: " <> int.to_string(not_spoiled))
  // Part 2
  let not_spoiled = part2(lines)
  io.println("Part 2 - Total not spoiled: " <> int.to_string(not_spoiled))
}

/// Returns the number of ingredients in lines that aren't spoiled.
pub fn part1(lines: List(String)) -> Int {
  // Store checks
  let #(ingredients, checks) = get_checks(lines, [])
  // Check the ingredients
  let not_spoiled = check_each_ingredient(checks, ingredients, 0)
  not_spoiled
}

fn get_checks(
  lines: List(String),
  checks: List(Range),
) -> #(List(String), List(Range)) {
  let assert [line, ..the_rest] = lines
  case line {
    "" -> #(the_rest, checks)
    _ -> {
      let assert Ok(#(start, end)) = string.split_once(line, "-")
      let assert Ok(start) = int.parse(start)
      let assert Ok(end) = int.parse(end)
      let range = Range(start, end)
      get_checks(the_rest, [range, ..checks])
    }
  }
}

// Part 1
fn check_each_ingredient(
  checks: List(Range),
  ingredients: List(String),
  not_spoiled: Int,
) -> Int {
  case ingredients {
    [] -> not_spoiled
    ["", ..the_rest] -> check_each_ingredient(checks, the_rest, not_spoiled)
    [id, ..the_rest] -> {
      let assert Ok(id_int) = int.parse(id)
      case is_spoiled(checks, id_int) {
        True -> check_each_ingredient(checks, the_rest, not_spoiled)
        False -> check_each_ingredient(checks, the_rest, not_spoiled + 1)
      }
    }
  }
}

/// Returns whether the ingredient with `id` is spoiled
fn is_spoiled(checks: List(Range), id: Int) -> Bool {
  case checks {
    [] -> True
    [Range(start, end), ..the_rest] -> {
      case Nil {
        _ if start <= id && id <= end -> False
        _ -> is_spoiled(the_rest, id)
      }
    }
  }
}

// Part 2
pub fn part2(lines: List(String)) -> Int {
  let #(_, checks) = get_checks(lines, [])
  let ranges =
    checks
    |> list.sort(fn(a, b) { int.compare(a.from, b.from) })
  let assert [first, ..ranges] = ranges
  let ranges = merge(ranges, [first])
  // between 369761800782529..<369761800782629
  sum_ranges(ranges, 0)
}

fn merge(ranges: List(Range), merged: List(Range)) -> List(Range) {
  case ranges {
    [] -> merged
    [range, ..rest] -> {
      let assert [merged_range, ..rest_merged] = merged
      case range.from <= merged_range.to + 1 {
        True ->
          merge(rest, [
            Range(merged_range.from, int.max(merged_range.to, range.to)),
            ..rest_merged
          ])
        False -> merge(rest, [range, ..merged])
      }
    }
  }
}

fn sum_ranges(ranges: List(Range), sum: Int) -> Int {
  case ranges {
    [] -> sum
    [range, ..rest] -> sum_ranges(rest, sum + { range.to - range.from + 1 })
  }
}
