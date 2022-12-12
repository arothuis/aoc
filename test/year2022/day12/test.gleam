import gleeunit/should
import year2022/day12 as day
import util/aoc

fn example1() {
  aoc.get_input(2022, 12, "example1")
}

fn example2() {
  aoc.get_input(2022, 12, "example2")
}

fn example3() {
  aoc.get_input(2022, 12, "example3")
}

fn example4() {
  aoc.get_input(2022, 12, "example4")
}

// fn input() {
//   aoc.get_input(2022, 12, "input")
// }

pub fn example_a1_test() {
  day.solve_a(example1())
  |> should.equal(27)
}

pub fn example_a2_test() {
  day.solve_a(example2())
  |> should.equal(29)
}

pub fn example_a3_test() {
  day.solve_a(example3())
  |> should.equal(28)
}

pub fn example_a4_test() {
  day.solve_a(example4())
  |> should.equal(31)
}

// Yikes, timeout! Use `gleam run` for this one
// pub fn solve_a_test() {
//   day.solve_a(input())
//   |> should.equal(481)
// }

pub fn example_b1_test() {
  day.solve_b(example1())
  |> should.equal(26)
}

pub fn example_b2_test() {
  day.solve_b(example2())
  |> should.equal(26)
}

pub fn example_b3_test() {
  day.solve_b(example3())
  |> should.equal(26)
}

pub fn example_b4_test() {
  day.solve_b(example4())
  |> should.equal(29)
}
// Yikes, timeout! Use `gleam run` for this one
// pub fn solve_b_test() {
//   day.solve_b(input())
//   |> should.equal(13954061248)
// }
