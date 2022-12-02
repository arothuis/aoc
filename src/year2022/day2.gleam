import gleam/string
import gleam/list
import gleam/int

fn parse_round_a(input: String) -> Int {
  let [theirs, mine] = string.split(input, " ")
  case theirs, mine {
    "A", "X" -> 4
    "A", "Y" -> 8
    "A", "Z" -> 3
    "B", "X" -> 1
    "B", "Y" -> 5
    "B", "Z" -> 9
    "C", "X" -> 7
    "C", "Y" -> 2
    "C", "Z" -> 6
  }
}

fn parse_round_b(input: String) -> Int {
  let [theirs, outcome] = string.split(input, " ")
  case theirs, outcome {
    "A", "X" -> 3
    "A", "Y" -> 4
    "A", "Z" -> 8
    "B", "X" -> 1
    "B", "Y" -> 5
    "B", "Z" -> 9
    "C", "X" -> 2
    "C", "Y" -> 6
    "C", "Z" -> 7
  }
}

pub fn solve_a(input: String) -> Int {
  string.split(input, "\n")
    |> list.map(parse_round_a)
    |> int.sum
}

pub fn solve_b(input: String) -> Int {
  string.split(input, "\n")
    |> list.map(parse_round_b)
    |> int.sum
}
