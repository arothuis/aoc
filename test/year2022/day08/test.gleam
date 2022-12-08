import gleeunit/should
import year2022/day08 as day
import util/aoc

fn example() {
  aoc.get_input(2022, 8, "example")
}

fn input() {
  aoc.get_input(2022, 8, "input")
}

pub fn example_a_test() {
  day.solve_a(example())
  |> should.equal(21)
}

pub fn solve_a_test() {
  day.solve_a(input())
  |> should.equal(1647)
}

pub fn example_b_test() {
  day.solve_b(example())
  |> should.equal(8)
}

pub fn solve_b_test() {
  day.solve_b(input())
  |> should.equal(392080)
}

pub fn supporting_functions_test() {
  day.visibility_ltr([2, 5, 5, 1, 2])
  |> should.equal([1, 1, 0, 0, 0])

  day.visibility_line([2, 5, 5, 1, 2])
  |> should.equal([1, 1, 1, 0, 1])

  day.scenic_ltr([2, 5, 5, 1, 2])
  |> should.equal([0, 1, 1, 1, 2])

  day.scenic_ltr([2, 1, 5, 5, 2])
  |> should.equal([0, 1, 2, 1, 1])

  day.scenic_ltr([3, 5, 3, 5, 3])
  |> should.equal([0, 1, 1, 2, 1])

  day.scenic_line([2, 5, 5, 1, 2])
  |> should.equal([0, 1, 2, 1, 0])
}
