import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/string
import simplifile

pub fn main_() -> Nil {
  let assert Ok(file) = simplifile.read(from: "./input.txt")
  let lines = string.split(file, on: "\n")
  let not_spoiled = part1(lines)
  io.println("Part 1 - Not spoiled: " <> int.to_string(not_spoiled))
}

/// Returns the number of ingredients in lines that aren't spoiled.
pub fn part1(lines: List(String)) -> Int {
  // Store checks
  let #(dct, lines) = dict.new() |> populate_dict(lines)
  // Check the ingredients
  let not_spoiled = check_each_ingredient(dct, lines, 0)
  not_spoiled
}

type Range {
  Range(from: Int, to: Int)
}

type RangeDict =
  Dict(String, List(Range))

fn check_each_ingredient(
  dct: RangeDict,
  ingredients: List(String),
  not_spoiled: Int,
) -> Int {
  case ingredients {
    [] | [""] -> not_spoiled
    [id, ..the_rest] -> {
      let assert Ok(first_digit) = string.first(id)
      let assert Ok(id_int) = int.parse(id)
      let checks = case dict.get(dct, first_digit) {
        Error(_) -> []
        Ok(checks) -> checks
      }
      case is_spoiled(checks, id_int) {
        True -> check_each_ingredient(dct, the_rest, not_spoiled)
        False -> check_each_ingredient(dct, the_rest, not_spoiled + 1)
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

fn populate_dict(
  dct: RangeDict,
  lines: List(String),
) -> #(RangeDict, List(String)) {
  let assert [line, ..the_rest] = lines
  case line {
    "" -> #(dct, the_rest)
    _ -> {
      // Split by '-'
      let assert Ok(#(start, end)) = string.split_once(line, "-")
      // Get first digit
      let assert Ok(start_first_digit) = string.first(start)
      let assert Ok(end_first_digit) = string.first(end)
      // Parse integers
      let assert Ok(start_int) = int.parse(start)
      let assert Ok(end_int) = int.parse(end)
      // New range
      let range = Range(start_int, end_int)
      // Add new range
      let dct =
        try_append_dict(dct, start_first_digit, range)
        // Add end digit if != start
        |> check_match_or_append(
          if_not: start_first_digit,
          then_set: end_first_digit,
          appending: range,
        )
      // There are more to add
      populate_dict(dct, the_rest)
    }
  }
}

fn check_match_or_append(
  dct: Dict(String, List(b)),
  if_not match: String,
  then_set key: String,
  appending item: b,
) -> Dict(String, List(b)) {
  case key {
    _ if key == match -> dct
    _ -> try_append_dict(dct, key, item)
  }
}

fn try_append_dict(dct: Dict(a, List(b)), key: a, item: b) -> Dict(a, List(b)) {
  case dict.get(dct, key) {
    Ok(existing_list) -> dict.insert(dct, key, [item, ..existing_list])
    Error(_) -> dict.insert(dct, key, [item])
  }
}
