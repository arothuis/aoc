import gleam/int
import gleam/string
import gleam/erlang/file

pub fn get_input(year: Int, day: Int, name: String) {
  let padded_day =
    int.to_string(day)
    |> string.pad_left(2, "0")

  let path =
    string.join(
      [
        "test",
        "year" <> int.to_string(year),
        "day" <> padded_day,
        name <> ".txt",
      ],
      "/",
    )

  assert Ok(input) = file.read(path)
  input
}
