import gleeunit/should
import year2022/day3 as day
import util/aoc

fn example() {
  aoc.get_input(2022, 3, "example")
}

fn input() {
  aoc.get_input(2022, 3, "input")
}

pub fn example_a_test() {
  day.solve_a(example())
  |> should.equal(157)
}

pub fn solve_a_test() {
  day.solve_a(input())
  |> should.equal(7716)
}

pub fn example_b_test() {
  day.solve_b(example())
  |> should.equal(70)
}

pub fn solve_b_test() {
  day.solve_b(input())
  |> should.equal(2973)
}
