import gleam/string
import gleam/list
import gleam/result
import gleam/option.{Some}
import gleam/int
import gleam/function
import gleam/map.{Map}

pub fn solve_a(input: String) -> String {
  solve(input, list.reverse)
}

pub fn solve_b(input: String) -> String {
  solve(input, function.identity)
}

fn solve(input: String, stacking_method: fn(List(String)) -> List(String)) {
  let [start, commands] = string.split(input, "\n\n")

  list.fold(
    parse_commands(commands),
    parse_start(start),
    apply(stacking_method),
  )
  |> map.values
  |> list.map(fn(n) { result.unwrap(list.first(n), "") })
  |> string.join("")
}

type State =
  Map(Int, List(String))

type Command {
  Command(from: Int, to: Int, amount: Int)
}

fn parse_start(start: String) -> State {
  string.split(start, "\n")
  |> list.map(fn(line) {
    list.index_fold(
      string.to_graphemes(line),
      [],
      fn(acc, item, index) {
        case int.remainder(index - 1, 4) {
          Ok(0) -> [item, ..acc]
          _ -> acc
        }
      },
    )
    |> list.reverse
  })
  |> list.transpose
  |> list.map(list.filter(_, fn(n) { n != " " }))
  |> fn(xs) { list.zip(list.range(0, list.length(xs)), xs) }
  |> map.from_list
}

fn parse_commands(input: String) -> List(Command) {
  string.split(input, "\n")
  |> list.map(fn(n) {
    let [_, a, _, b, _, c] = string.split(n, " ")

    assert Ok(amount) = int.parse(a)
    assert Ok(from) = int.parse(b)
    assert Ok(to) = int.parse(c)

    Command(from - 1, to - 1, amount)
  })
}

fn apply(
  stacking_method: fn(List(String)) -> List(String),
) -> fn(State, Command) -> State {
  fn(state: State, command: Command) {
    assert Ok(next_state) =
      result.then(
        map.get(state, command.from),
        fn(from_stack) {
          let #(moved, remains) = list.split(from_stack, command.amount)

          let next =
            map.update(state, command.from, fn(_) { remains })
            |> map.update(
              command.to,
              fn(previous_to) {
                case previous_to {
                  Some(to_stack) ->
                    list.append(stacking_method(moved), to_stack)
                  _ -> []
                }
              },
            )

          Ok(next)
        },
      )

    next_state
  }
}
