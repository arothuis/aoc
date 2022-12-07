import gleam/int
import gleam/list
import gleam/map.{Map}
import gleam/result
import gleam/string
import gleam/option.{None, Option, Some}

pub fn solve_a(input: String) -> Int {
  analyze_dirs(input)
  |> map.fold(
    0,
    fn(acc, _, value) {
      case value <= 100000 {
        True -> acc + value
        False -> acc
      }
    },
  )
}

pub fn solve_b(input: String) -> Int {
  let max_space = 70000000
  let required_space = 30000000

  let dirs = analyze_dirs(input)
  assert Ok(used) = map.get(dirs, ["/"])
  let to_free = required_space - { max_space - used }

  map.values(dirs)
  |> list.sort(int.compare)
  |> list.find(fn(size) { size >= to_free })
  |> result.unwrap(0)
}

type Context {
  Context(dirs: List(String), seen: Map(List(String), Int))
}

fn analyze_dirs(input: String) -> Map(List(String), Int) {
  string.split(input, "\n")
  |> list.fold(Context([], map.new()), process_line)
  |> go_up_a_dir
  |> fn(n: Context) { n.seen }
}

fn add_size(new_size: Int) {
  fn(old: Option(Int)) {
    case old {
      Some(old_size) -> old_size + new_size
      None -> 0 + new_size
    }
  }
}

fn process_line(context: Context, line: String) -> Context {
  case string.split(string.trim(line), " ") {
    ["$", "cd", ".."] -> go_up_a_dir(context)
    ["$", "cd", dir] -> go_into_dir(context, dir)
    ["dir", _dir] -> context
    ["$", "ls"] -> context
    [size, _file] -> add_file_size(context, result.unwrap(int.parse(size), 0))
    _ -> context
  }
}

fn go_up_a_dir(context) -> Context {
  let [_, ..parent] = context.dirs
  let child_size =
    map.get(context.seen, context.dirs)
    |> result.unwrap(0)
  Context(
    dirs: parent,
    seen: map.update(context.seen, parent, add_size(child_size)),
  )
}

fn go_into_dir(context, dir) -> Context {
  Context(..context, dirs: [dir, ..context.dirs])
}

fn add_file_size(context, size) -> Context {
  Context(
    ..context,
    seen: map.update(context.seen, context.dirs, add_size(size)),
  )
}
