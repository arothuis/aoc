import util/text
import gleeunit/should

pub fn wrap_test() {
  "hello"
  |> text.wrap(with: "!")
  |> should.equal("!hello!")
}

pub fn inset_test() {
  "hello"
  |> text.inset(between: #("[", "]"))
  |> should.equal("[hello]")
}
