import gleam/int
import gleam/list
import gleam/result
import gleam/set.{Set}
import gleam/string

pub fn solve_a(input: String) -> Int {
  string.split(input, "\n")
  |> simulate_rope(2)
}

pub fn solve_b(input: String) -> Int {
  string.split(input, "\n")
  |> simulate_rope(10)
}

pub type Rope {
  Rope(pieces: List(#(Int, Int)), tails: Set(#(Int, Int)))
}

pub fn simulate_rope(lines: List(String), rope_size: Int) -> Int {
  Rope(list.repeat(#(0, 0), rope_size), set.new())
  |> list.fold(
    lines,
    _,
    fn(rope: Rope, line: String) {
      let [dir, n] = string.split(line, " ")
      let step = case dir {
        "U" -> #(0, 1)
        "D" -> #(0, -1)
        "L" -> #(-1, 0)
        "R" -> #(1, 0)
      }

      string.trim(n)
      |> int.parse
      |> result.unwrap(0)
      |> list.repeat(step, _)
      |> list.fold(rope, move_rope_step)
    },
  )
  |> fn(rope: Rope) { set.size(rope.tails) }
}

pub fn move_rope_step(rope: Rope, step: #(Int, Int)) -> Rope {
  let Rope([head, ..rest], history) = rope
  let next_head = #(head.0 + step.0, head.1 + step.1)
  let next_rest = list.scan(rest, next_head, move_piece_step)
  assert Ok(next_tail) = list.last(next_rest)

  Rope([next_head, ..next_rest], set.insert(history, next_tail))
}

fn move_piece_step(head: #(Int, Int), tail: #(Int, Int)) -> #(Int, Int) {
  let delta_x = head.0 - tail.0
  let delta_y = head.1 - tail.1

  case int.absolute_value(delta_x), int.absolute_value(delta_y) {
    0, 0 | 0, 1 | 1, 0 | 1, 1 -> tail
    _, _ -> #(tail.0 + normal(delta_x), tail.1 + normal(delta_y))
  }
}

fn normal(n: Int) {
  case n {
    _ if n > 0 -> 1
    _ if n < 0 -> -1
    _ -> 0
  }
}
