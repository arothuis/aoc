import gleam/int
import gleam/list
import gleam/string

pub fn solve_a(input: String) -> Int {
  string.split(input, "\n")
  |> list.fold(Context(1, 0, []), process_line)
  |> calculate_signal
}

pub fn solve_b(input: String) -> String {
  string.split(input, "\n")
  |> list.fold(Context(1, 0, []), draw_pixels)
  |> render_screen
}

pub type Context(a) {
  Context(x: Int, cycles: Int, history: List(a))
}

fn render_screen(context: Context(String)) -> String {
  list.reverse(context.history)
  |> list.sized_chunk(40)
  |> list.map(fn(row) { string.join(row, "") })
  |> string.join("\n")
}

fn draw_pixels(context: Context(String), line: String) -> Context(String) {
  let Context(x, cycles, history) = context
  case string.split(line, " ") {
    ["addx", n] -> {
      assert Ok(add) = int.parse(string.trim(n))
      Context(
        x + add,
        cycles + 2,
        [draw_pixel(x, cycles + 2), draw_pixel(x, cycles + 1), ..history],
      )
    }
    _ -> Context(x, cycles + 1, [draw_pixel(x, cycles + 1), ..history])
  }
}

fn draw_pixel(x: Int, cycle: Int) -> String {
  assert Ok(position) = int.remainder(cycle - 1, 40)
  case x - 1 == position || x == position || x + 1 == position {
    True -> "#"
    False -> "."
  }
}

fn calculate_signal(context: Context(Int)) -> Int {
  list.reverse(context.history)
  |> list.index_fold(
    0,
    fn(acc, x, i) {
      case i + 1 {
        20 | 60 | 100 | 140 | 180 | 220 -> acc + x * { i + 1 }
        _ -> acc
      }
    },
  )
}

fn process_line(context: Context(Int), line: String) -> Context(Int) {
  let Context(x, cycles, history) = context
  case string.split(line, " ") {
    ["addx", n] -> {
      assert Ok(add) = int.parse(string.trim(n))
      Context(x: x + add, cycles: cycles + 2, history: [x + add, x, ..history])
    }
    _ -> Context(x: x, cycles: cycles + 1, history: [x, ..history])
  }
}
