import gleam/function
import gleam/int
import gleam/io
import gleam/list
import gleam/map.{Map}
import gleam/option.{None, Option, Some}
import gleam/string

pub fn solve_a(input: String) -> Int {
  let relieve = fn(n) {
    assert Ok(result) = int.floor_divide(n, 3)
    result
  }
  string.split(input, "\n\n")
  |> list.map(parse_monkey)
  |> solve(20, relieve)
}

pub fn solve_b(input: String) -> Int {
  let monkeys =
    string.split(input, "\n\n")
    |> list.map(parse_monkey)
  let divisor_product = list.fold(monkeys, 1, fn(acc, m) { acc * m.divisor })
  let relieve = fn(n) {
    assert Ok(result) = int.remainder(n, divisor_product)
    result
  }

  solve(monkeys, 10_000, relieve)
}

fn solve(monkeys: List(Monkey), times: Int, relieve: fn(Int) -> Int) -> Int {
  let initial_items = list.fold(monkeys, map.new(), initialize_items)
  let #(_, counts) =
    list.range(1, times)
    |> list.fold(
      #(initial_items, map.new()),
      fn(acc, _) { process_round(acc, monkeys, relieve) },
    )

  map.values(counts)
  |> list.sort(function.flip(int.compare))
  |> list.take(2)
  |> list.fold(1, int.multiply)
}

type Monkey {
  Monkey(
    id: Int,
    items: List(Int),
    op: fn(Int) -> Int,
    divisor: Int,
    when_true: Int,
    when_false: Int,
  )
}

type Items =
  Map(Int, List(Int))

type Counts =
  Map(Int, Int)

fn process_round(
  context: #(Items, Counts),
  monkeys: List(Monkey),
  relieve: fn(Int) -> Int,
) {
  list.fold(
    monkeys,
    context,
    fn(count, monkey) { process_turn(count, monkey, relieve) },
  )
}

fn process_turn(
  context: #(Items, Counts),
  monkey: Monkey,
  relieve: fn(Int) -> Int,
) {
  let #(all_items, counts) = context
  assert Ok(items) = map.get(all_items, monkey.id)

  let inspected = list.map(items, inspect_item(_, monkey.op, relieve))
  let next_count =
    map.update(counts, monkey.id, update_count(_, list.length(inspected)))
  let #(trues, falses) =
    list.partition(inspected, is_divisible_by(_, monkey.divisor))
  let next_items =
    map.insert(all_items, monkey.id, [])
    |> map.update(monkey.when_true, throw_items(_, trues))
    |> map.update(monkey.when_false, throw_items(_, falses))
  #(next_items, next_count)
}

fn inspect_item(n: Int, operation: fn(Int) -> Int, relieve: fn(Int) -> Int) {
  operation(n)
  |> relieve
}

fn update_count(old: Option(Int), amount: Int) -> Int {
  case old {
    None -> amount
    Some(n) -> n + amount
  }
}

fn throw_items(old: Option(List(Int)), items: List(Int)) -> List(Int) {
  case old {
    None -> items
    Some(ns) -> list.append(items, ns)
  }
}

fn is_divisible_by(i: Int, divisor: Int) -> Bool {
  assert Ok(result) = int.remainder(i, divisor)
  result == 0
}

fn initialize_items(items: Items, monkey: Monkey) -> Map(Int, List(Int)) {
  map.insert(items, monkey.id, monkey.items)
}

fn parse_monkey(input: String) {
  let attributes = string.split(input, "\n")
  Monkey(
    parse_id(get_attribute(attributes, 0)),
    parse_start(get_attribute(attributes, 1)),
    parse_op(get_attribute(attributes, 2)),
    parse_divisor(get_attribute(attributes, 3)),
    parse_when(get_attribute(attributes, 4)),
    parse_when(get_attribute(attributes, 5)),
  )
}

fn parse_id(a: String) -> Int {
  string.drop_right(a, 1)
  |> string.drop_left(7)
  |> parse_int
}

fn parse_start(a: String) -> List(Int) {
  string.drop_left(a, 18)
  |> string.split(", ")
  |> list.map(parse_int)
}

fn parse_op(a: String) -> fn(Int) -> Int {
  let [left, op, right] = string.split(string.drop_left(a, 19), " ")
  fn(x) {
    case op {
      "+" -> parse_operand(left, x) + parse_operand(right, x)
      "*" -> parse_operand(left, x) * parse_operand(right, x)
    }
  }
}

fn parse_divisor(a: String) -> Int {
  parse_int(string.drop_left(a, 21))
}

fn parse_when(a: String) -> Int {
  let [_, x] = string.split(a, ": ")
  parse_int(string.drop_left(x, 16))
}

fn parse_operand(a: String, x: Int) {
  case a {
    "old" -> x
    _ -> parse_int(a)
  }
}

fn get_attribute(attributes: List(String), i: Int) -> String {
  assert Ok(attr) = list.at(attributes, i)
  attr
}

fn parse_int(a: String) {
  assert Ok(a) = int.parse(a)
  a
}
