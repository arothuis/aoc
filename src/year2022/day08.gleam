import gleam/int
import gleam/list.{Continue, Stop}
import gleam/result
import gleam/string
import gleam/io
import util/collection

pub fn solve_a(input: String) -> Int {
  string.split(input, "\n")
  |> list.map(parse_line)
  |> visibility_square
  |> list.flatten
  |> list.fold(0, int.add)
}

pub fn solve_b(input: String) -> Int {
  string.split(input, "\n")
  |> list.map(parse_line)
  |> scenic_square
  |> list.flatten
  |> list.fold(0, int.max)
}

fn score(seen: List(Int), tree: Int) {
  case seen {
    [] -> 0
    _ ->
      list.fold_until(
        seen,
        0,
        fn(acc, before) {
          case before {
            _ if before < tree -> Continue(acc + 1)
            _ if before >= tree -> Stop(acc + 1)
          }
        },
      )
  }
}

fn scenic_square(heights: List(List(Int))) -> List(List(Int)) {
  let square_a = list.map(heights, scenic_line)
  let square_b = list.transpose(list.map(list.transpose(heights), scenic_line))

  list.index_map(
    square_a,
    fn(i, row_a) {
      assert Ok(row_b) = list.at(square_b, i)
      collection.zip_with(row_a, row_b, int.multiply)
    },
  )
}

pub fn scenic_line(heights: List(Int)) -> List(Int) {
  collection.zip_with(
    scenic_ltr(heights),
    list.reverse(scenic_ltr(list.reverse(heights))),
    int.multiply,
  )
}

pub fn scenic_ltr(heights: List(Int)) -> List(Int) {
  let #(_, results) =
    list.fold(
      heights,
      #([], []),
      fn(acc, next) {
        let #(seen, results) = acc
        #([next, ..seen], [score(seen, next), ..results])
      },
    )

  list.reverse(results)
}

fn visibility_square(heights: List(List(Int))) -> List(List(Int)) {
  let square_a = list.map(heights, visibility_line)
  let square_b =
    list.transpose(list.map(list.transpose(heights), visibility_line))

  list.index_map(
    square_a,
    fn(i, row_a) {
      assert Ok(row_b) = list.at(square_b, i)
      collection.zip_with(row_a, row_b, int.max)
    },
  )
}

pub fn visibility_line(heights: List(Int)) -> List(Int) {
  collection.zip_with(
    visibility_ltr(heights),
    list.reverse(visibility_ltr(list.reverse(heights))),
    int.max,
  )
}

pub fn visibility_ltr(heights: List(Int)) -> List(Int) {
  let #(_, _, visibility) =
    list.fold(
      heights,
      #(-1, -1, []),
      fn(acc, next) {
        let #(prev, max, visibility) = acc
        case next > prev && next > max {
          False -> #(next, int.max(next, max), [0, ..visibility])
          True -> #(next, int.max(next, max), [1, ..visibility])
        }
      },
    )

  list.reverse(visibility)
}

fn visibility(seen: List(Int), tree: Int) {
  let visible =
    list.reverse(seen)
    |> list.all(fn(n) { n < tree })

  case visible {
    True -> 1
    False -> 0
  }
}

fn parse_line(input: String) -> List(Int) {
  string.trim(input)
  |> string.to_graphemes
  |> list.map(fn(n) { result.unwrap(int.parse(n), 0) })
}
