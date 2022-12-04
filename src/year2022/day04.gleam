import gleam/int
import gleam/list
import gleam/string

pub fn solve_a(input: String) -> Int {
  count_inefficiencies(input, is_fully_contained)
}

pub fn solve_b(input: String) -> Int {
  count_inefficiencies(input, has_overlap)
}

fn count_inefficiencies(
  input: String,
  qualify: fn(Section, Section) -> Bool,
) -> Int {
  string.split(input, "\n")
  |> list.map(parse_sections)
  |> list.filter(fn(section) { qualify(section.0, section.1) })
  |> list.length
}

type Section =
  #(Int, Int)

fn parse_section(input: String) -> Section {
  let [start, end] =
    string.split(input, "-")
    |> list.filter_map(int.parse)

  #(start, end)
}

fn parse_sections(input: String) -> #(Section, Section) {
  let [a, b] =
    string.split(input, ",")
    |> list.map(parse_section)

  #(a, b)
}

fn is_fully_contained(a: Section, b: Section) -> Bool {
  a.0 >= b.0 && a.1 <= b.1 || b.0 >= a.0 && b.1 <= a.1
}

fn has_overlap(a: Section, b: Section) -> Bool {
  a.0 >= b.0 && a.0 <= b.1 || b.0 >= a.0 && b.0 <= a.1
}
