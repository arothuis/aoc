import gleam/map
import gleeunit/should
import util/collection

pub fn count_elements_test() {
  [2, 1, 2, 1, 2, 3]
  |> collection.count_elements
  |> should.equal(map.from_list([#(1, 2), #(2, 3), #(3, 1)]))
}
