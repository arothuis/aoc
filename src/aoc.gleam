import year2022/day12
import util/aoc
import gleam/io

pub fn main() {
  // day12.solve_a(aoc.get_input(2022, 12, "input"))
  // |> io.debug

  day12.solve_b(aoc.get_input(2022, 12, "input"))
  |> io.debug
}
