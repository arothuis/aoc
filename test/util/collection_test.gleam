import gleam/list
import gleam/map
import gleeunit/should
import util/collection

pub fn count_elements_test() {
  [2, 1, 2, 1, 2, 3]
  |> collection.count_elements
  |> should.equal(map.from_list([#(1, 2), #(2, 3), #(3, 1)]))
}

pub fn zip_with_test() {
  collection.zip_with([], [], fn(a, b) { a + b })
  |> should.equal([])

  collection.zip_with([], [1, 2, 3], fn(a, b) { a + b })
  |> should.equal([])

  collection.zip_with([1, 2], [], fn(a, b) { a + b })
  |> should.equal([])

  collection.zip_with([1, 2, 3], [4, 5, 6], fn(a, b) { a + b })
  |> should.equal([5, 7, 9])
}
