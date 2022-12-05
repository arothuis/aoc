import gleeunit/should
import year2022/day05 as day
import util/aoc

fn example() {
  aoc.get_input(2022, 5, "example")
}

fn input() {
  aoc.get_input(2022, 5, "input")
}

pub fn example_a_test() {
  day.solve_a(example())
  |> should.equal("CMZ")
}

pub fn solve_a_test() {
  day.solve_a(input())
  |> should.equal("TBVFVDZPN")
}

pub fn example_b_test() {
  day.solve_b(example())
  |> should.equal("MCD")
}

pub fn solve_b_test() {
  day.solve_b(input())
  |> should.equal("VLCWHTDSZ")
}
