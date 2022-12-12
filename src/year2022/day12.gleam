import gleam/function
import gleam/list
import gleam/result
import gleam/string
import gleam/map.{Map}

pub fn solve_a(input: String) -> Int {
  let #(start, end, heights) =
    string.split(input, "\n")
    |> list.index_fold(#(#(-1, -1), #(-1, -1), map.new()), parse_row)

  step(start, end, heights, 0, map.new())
  |> map.get(end)
  |> result.unwrap(0)
}

pub fn solve_b(input: String) -> Int {
  let #(_, end, heights) =
    string.split(input, "\n")
    |> list.index_fold(#(#(-1, -1), #(-1, -1), map.new()), parse_row)

  heights
  |> map.filter(fn(coord, height) {
    case height == 97 {
      False -> False
      True ->
        list.filter(
          get_options(coord, heights),
          fn(opt) {
            assert Ok(x) = map.get(heights, opt)
            x > 97
          },
        )
        |> list.length > 0
    }
  })
  |> map.keys
  |> list.fold(
    map.new(),
    fn(acc: Map(Coord, Int), start: Coord) { step(start, end, heights, 0, acc) },
  )
  |> fn(seen) { map.get(seen, end) }
  |> result.unwrap(0)
}

fn step(current, end, heights, steps, seen) {
  let too_far = case map.get(seen, current) {
    Ok(prev_steps) -> steps >= prev_steps
    _ -> False
  }

  let next_seen = map.insert(seen, current, steps)
  case too_far, current == end {
    True, _ -> seen
    _, True -> next_seen
    _, _ ->
      get_options(current, heights)
      |> list.fold(
        next_seen,
        fn(acc, opt) { step(opt, end, heights, steps + 1, acc) },
      )
  }
}

type Coord =
  #(Int, Int)

fn get_options(current: Coord, heights: Map(Coord, Int)) {
  let #(x, y) = current
  [
    get_option(heights, current, #(x + 1, y)),
    get_option(heights, current, #(x - 1, y)),
    get_option(heights, current, #(x, y + 1)),
    get_option(heights, current, #(x, y - 1)),
  ]
  |> list.filter_map(function.identity)
}

fn get_option(heights: Map(Coord, Int), current: Coord, next: Coord) {
  assert Ok(from) = map.get(heights, current)
  case map.get(heights, next) {
    Ok(to) ->
      case to - from < 2 {
        True -> Ok(next)
        False -> Error(Nil)
      }
    _ -> Error(Nil)
  }
}

fn parse_row(context: #(Coord, Coord, Map(Coord, Int)), row: String, y: Int) {
  string.to_graphemes(row)
  |> list.index_fold(
    context,
    fn(ctx, height, x) {
      let #(start, end, heights) = ctx
      let height_map = map.insert(heights, #(x, y), to_height(height))
      case height {
        "S" -> #(#(x, y), end, height_map)
        "E" -> #(start, #(x, y), height_map)
        _ -> #(start, end, height_map)
      }
    },
  )
}

fn to_height(height: String) {
  case height {
    "S" -> 97
    "E" -> 122
    _ -> {
      let <<h:int>> = <<height:utf8>>
      h
    }
  }
}
