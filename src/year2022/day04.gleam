import gleam/function
import gleam/int
import gleam/list
import gleam/string

pub fn solve_a(input: String) -> Int {
  string.split(input, "\n")
  |> list.map(parse_sections)
  |> list.filter(is_fully_contained)
  |> list.length
}

pub fn solve_b(input: String) -> Int {
  string.split(input, "\n")
  |> list.map(parse_sections)
  |> list.filter(has_overlap)
  |> list.length
}

type Section =
  #(Int, Int)

fn parse_section(input: String) -> Section {
  assert Ok(section) =
    string.split(input, "-")
    |> list.filter_map(int.parse)
    |> list.combination_pairs
    |> list.first

  section
}

fn parse_sections(input: String) -> #(Section, Section) {
  assert Ok(sections) =
    string.split(input, ",")
    |> list.map(parse_section)
    |> list.combination_pairs
    |> list.first

  sections
}

fn is_fully_contained(sections: #(Section, Section)) -> Bool {
  let #(#(a_start, a_end), #(b_start, b_end)) = sections
  a_start >= b_start && a_end <= b_end || b_start >= a_start && b_end <= a_end
}

fn has_overlap(sections: #(Section, Section)) -> Bool {
  let #(#(a_start, a_end), #(b_start, b_end)) = sections
  a_start >= b_start && a_start <= b_end || b_start >= a_start && b_start <= a_end
}
