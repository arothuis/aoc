import gleam/map.{Map}
import gleam/option.{None, Some}

pub fn count_elements(xs: List(a)) {
  do_count_elements(xs, map.new())
}

fn do_count_elements(xs: List(a), seen: Map(a, Int)) {
  case xs {
    [] -> seen
    [x, ..tail] -> do_count_elements(tail, map.update(seen, x, count))
  }
}

fn count(previous) {
  case previous {
    Some(n) -> n + 1
    None -> 1
  }
}
