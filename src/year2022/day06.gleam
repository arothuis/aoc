import gleam/function
import gleam/list
import gleam/string
import gleam/int

pub fn solve_a(input: String) -> Int {
  find_start_marker(input, 4)
}

pub fn solve_b(input: String) -> Int {
  find_start_marker(input, 14)
}

fn find_start_marker(input: String, char_count: Int) -> Int {
  string.to_graphemes(input)
  |> list.window(char_count)
  |> list.map(function.compose(list.unique, list.length))
  |> list.take_while(fn(length) { length < char_count })
  |> list.length
  |> int.add(char_count)
}
