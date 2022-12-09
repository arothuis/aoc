import gleam/int
import gleam/list.{Continue, Stop}
import gleam/result
import gleam/string
import util/collection

pub fn solve_a(input: String) -> Int {
  string.split(input, "\n")
  |> list.map(parse_line)
  |> fold_square(visibility, int.max)
  |> list.flatten
  |> list.fold(0, int.add)
}

pub fn solve_b(input: String) -> Int {
  string.split(input, "\n")
  |> list.map(parse_line)
  |> fold_square(scenic_score, int.multiply)
  |> list.flatten
  |> list.fold(0, int.max)
}

fn visibility(seen: List(Int), tree: Int) {
  let visible = list.all(list.reverse(seen), fn(n) { n < tree })
  case visible {
    True -> 1
    False -> 0
  }
}

fn scenic_score(seen: List(Int), tree: Int) {
  list.fold_until(
    seen,
    0,
    fn(acc, before) {
      case before >= tree {
        False -> Continue(acc + 1)
        True -> Stop(acc + 1)
      }
    },
  )
}

fn fold_square(heights: List(List(Int)), process_fn, zip_fn) -> List(List(Int)) {
  let map_fn = fold_line(_, process_fn, zip_fn)
  let square_a = list.map(heights, map_fn)
  let square_b = list.transpose(list.map(list.transpose(heights), map_fn))

  list.index_map(
    square_a,
    fn(i, row_a) {
      assert Ok(row_b) = list.at(square_b, i)
      collection.zip_with(row_a, row_b, zip_fn)
    },
  )
}

fn fold_line(heights, process_fn, zip_fn) -> List(Int) {
  collection.zip_with(
    fold_ltr(heights, process_fn),
    list.reverse(fold_ltr(list.reverse(heights), process_fn)),
    zip_fn,
  )
}

fn fold_ltr(heights: List(Int), process_fn) -> List(Int) {
  let #(_, results) =
    list.fold(
      heights,
      #([], []),
      fn(acc, next) {
        let #(seen, results) = acc
        #([next, ..seen], [process_fn(seen, next), ..results])
      },
    )

  list.reverse(results)
}

fn parse_line(input: String) -> List(Int) {
  string.trim(input)
  |> string.to_graphemes
  |> list.map(fn(n) { result.unwrap(int.parse(n), 0) })
}
