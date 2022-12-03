import gleeunit/should
import year2022/day04 as day
import util/aoc

fn example() {
  aoc.get_input(2022, 4, "example")
}

fn input() {
  aoc.get_input(2022, 4, "input")
}

pub fn example_a_test() {
  day.solve_a(example())
  |> should.equal(0)
}

pub fn solve_a_test() {
  day.solve_a(input())
  |> should.equal(0)
}

pub fn example_b_test() {
  day.solve_b(example())
  |> should.equal(0)
}

pub fn solve_b_test() {
  day.solve_b(input())
  |> should.equal(0)
}
