import gleam/string
import gleam/list
import gleam/int
import gleam/function

fn calories_from_overview(overview: String) -> Int {
  string.split(overview, "\n")
  |> list.fold(
    0,
    fn(total, cals) {
      assert Ok(calories) = int.parse(cals)
      total + calories
    },
  )
}

pub fn total_calories_per_elf(input: String) -> List(Int) {
  string.split(input, "\n\n")
  |> list.map(calories_from_overview)
  |> list.sort(function.flip(int.compare))
}

pub fn solve_a(input) {
  assert Ok(result) =
    total_calories_per_elf(input)
    |> list.first

  result
}

pub fn solve_b(input) {
  total_calories_per_elf(input)
  |> list.take(3)
  |> int.sum
}
