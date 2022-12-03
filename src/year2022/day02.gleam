import gleam/string
import gleam/list
import gleam/int

pub fn solve_a(input: String) -> Int {
  string.split(input, "\n")
  |> list.map(parse_round_a)
  |> int.sum
}

pub fn solve_b(input: String) -> Int {
  string.split(input, "\n")
  |> list.map(parse_round_b)
  |> int.sum
}

type Move {
  Rock
  Paper
  Scissors
}

type Outcome {
  Win
  Draw
  Lose
}

fn evaluate_moves(mine: Move, theirs: Move) -> Outcome {
  case mine == theirs {
    True -> Draw
    False ->
      case mine, theirs {
        Rock, Scissors | Paper, Rock | Scissors, Paper -> Win
        _, _ -> Lose
      }
  }
}

fn required_move(theirs: Move, outcome: Outcome) -> Move {
  case theirs, outcome {
    Rock, Win -> Paper
    Rock, Lose -> Scissors
    Paper, Win -> Scissors
    Paper, Lose -> Rock
    Scissors, Win -> Rock
    Scissors, Lose -> Paper
    _, Draw -> theirs
  }
}

fn score_move(move: Move) -> Int {
  case move {
    Rock -> 1
    Paper -> 2
    Scissors -> 3
  }
}

fn score_outcome(outcome: Outcome) -> Int {
  case outcome {
    Lose -> 0
    Draw -> 3
    Win -> 6
  }
}

fn parse_round_a(input: String) -> Int {
  let [left, right] = string.split(input, " ")

  let theirs = case left {
    "A" -> Rock
    "B" -> Paper
    "C" -> Scissors
  }
  let mine = case right {
    "X" -> Rock
    "Y" -> Paper
    "Z" -> Scissors
  }

  score_move(mine) + score_outcome(evaluate_moves(mine, theirs))
}

fn parse_round_b(input: String) -> Int {
  let [left, right] = string.split(input, " ")

  let theirs = case left {
    "A" -> Rock
    "B" -> Paper
    "C" -> Scissors
  }
  let outcome = case right {
    "X" -> Lose
    "Y" -> Draw
    "Z" -> Win
  }

  score_move(required_move(theirs, outcome)) + score_outcome(outcome)
}
