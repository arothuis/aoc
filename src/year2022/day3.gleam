import gleam/string
import gleam/list
import gleam/set.{Set}
import gleam/int
import gleam/function
import gleam/result
import gleam/io

fn prioritize(item: String) -> Int {
  case <<item:utf8>> {
    <<n:int>> if n >= 97 -> n - 96
    <<n:int>> -> n - 38
  }
}

fn find_double_item(rucksack: String) -> String {
  let items = string.to_graphemes(rucksack)
  let #(left, right) = list.split(items, list.length(items) / 2)

  assert Ok(item) =
    set.intersection(set.from_list(left), set.from_list(right))
    |> set.to_list
    |> list.first

  item
}

fn make_char_set(input: String) -> Set(String) {
  input 
    |> string.trim
    |> string.to_graphemes
    |> set.from_list
}

fn find_badge(group: List(String)) -> String {
  assert Ok(badge) =
    list.map(group, make_char_set)
    |> list.reduce(set.intersection)
    |> result.unwrap(set.new())
    |> set.to_list
    |> list.first

  badge
}

pub fn solve_a(input: String) -> Int {
  string.split(input, "\n")
  |> list.map(function.compose(find_double_item, prioritize))
  |> int.sum
}

pub fn solve_b(input: String) -> Int {
  string.split(input, "\n")
  |> list.sized_chunk(3)
  |> list.map(function.compose(find_badge, prioritize))
  |> int.sum
}
