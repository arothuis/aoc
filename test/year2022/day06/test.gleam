import gleeunit/should
import year2022/day06 as day
import util/aoc

fn example() {
  aoc.get_input(2022, 6, "example")
}

fn input() {
  aoc.get_input(2022, 6, "input")
}

pub fn example_a_test() {
  day.solve_a(example())
  |> should.equal(7)
}

pub fn solve_a_test() {
  day.solve_a(input())
  |> should.equal(1300)
}

pub fn example_b_test() {
  day.solve_b(example())
  |> should.equal(19)
}

pub fn solve_b_test() {
  day.solve_b(input())
  |> should.equal(3986)
}
