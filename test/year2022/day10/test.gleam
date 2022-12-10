import gleeunit/should
import year2022/day10 as day
import util/aoc
import gleam/string

fn example() {
  aoc.get_input(2022, 10, "example")
}

fn input() {
  aoc.get_input(2022, 10, "input")
}

pub fn example_a_test() {
  day.solve_a(example())
  |> should.equal(13360)
}

pub fn solve_a_test() {
  day.solve_a(input())
  |> should.equal(15260)
}

pub fn example_b_test() {
  day.solve_b(example())
  |> should.equal(string.join(
    [
      "##..##..##..##..##..##..##..##..##..##..",
      "###...###...###...###...###...###...###.",
      "####....####....####....####....####....",
      "#####.....#####.....#####.....#####.....",
      "######......######......######......####",
      "#######.......#######.......#######.....",
    ],
    "\n",
  ))
}

pub fn solve_b_test() {
  day.solve_b(input())
  |> should.equal(string.join(
    [
      "###...##..#..#.####..##..#....#..#..##..",
      "#..#.#..#.#..#.#....#..#.#....#..#.#..#.",
      "#..#.#....####.###..#....#....#..#.#....",
      "###..#.##.#..#.#....#.##.#....#..#.#.##.",
      "#....#..#.#..#.#....#..#.#....#..#.#..#.",
      "#.....###.#..#.#.....###.####..##...###.",
    ],
    "\n",
  ))
}
