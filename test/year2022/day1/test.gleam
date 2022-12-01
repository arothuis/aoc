import gleeunit/should
import year2022/day1 as day
import util/aoc

fn example() {
  aoc.get_input(2022, 1, "example")
}

fn input() {
  aoc.get_input(2022, 1, "input")
}

pub fn example_a_test() {
  day.solve_a(example())
  |> should.equal(24000)
}

pub fn solve_a_test() {
  day.solve_a(input())
  |> should.equal(70613)
}

pub fn example_b_test() {
  day.solve_b(example())
  |> should.equal(45000)
}

pub fn solve_b_test() {
  day.solve_b(input())
  |> should.equal(205805)
}
