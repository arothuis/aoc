import gleeunit/should
import year2022/day09 as day
import util/aoc

fn example1() {
  aoc.get_input(2022, 9, "example1")
}

fn example2() {
  aoc.get_input(2022, 9, "example2")
}

fn input() {
  aoc.get_input(2022, 9, "input")
}

pub fn example_a_test() {
  day.solve_a(example1())
  |> should.equal(13)
}

pub fn solve_a_test() {
  day.solve_a(input())
  |> should.equal(5874)
}

pub fn example_b1_test() {
  day.solve_b(example1())
  |> should.equal(1)
}

pub fn example_b2_test() {
  day.solve_b(example2())
  |> should.equal(36)
}

pub fn solve_b_test() {
  day.solve_b(input())
  |> should.equal(2467)
}
