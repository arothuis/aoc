import gleam/int.{to_string}
import gleam/erlang/file

pub fn get_input(year: Int, day: Int, name: String) {
  assert Ok(input) =
    file.read(
      "test/year" <> to_string(year) <> "/day" <> to_string(day) <> "/" <> name <> ".txt",
    )
  input
}
