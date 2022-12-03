import gleam/string
import gleam/list
import gleam/int
import gleam/function
import gleam/result

pub fn solve_a(input: String) -> Int {
  total_calories_per_elf(input)
  |> list.first
  |> result.unwrap(0)
}

pub fn solve_b(input: String) -> Int {
  total_calories_per_elf(input)
  |> list.take(3)
  |> int.sum
}

fn calories_from_overview(overview: String) -> Int {
  string.split(overview, "\n")
  |> list.map(function.compose(int.parse, result.unwrap(_, 0)))
  |> int.sum
}

fn total_calories_per_elf(input: String) -> List(Int) {
  string.split(input, "\n\n")
  |> list.map(calories_from_overview)
  |> list.sort(function.flip(int.compare))
}
