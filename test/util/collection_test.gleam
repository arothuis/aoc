import gleam/map
import gleam/order
import gleeunit/should
import util/collection

pub fn count_elements_test() {
  [2, 1, 2, 1, 2, 3]
  |> collection.count_elements
  |> should.equal(map.from_list([#(1, 2), #(2, 3), #(3, 1)]))
}

pub fn descending_order_test() {
  collection.descending_order(1, 1)
  |> should.equal(order.Eq)

  collection.descending_order(1, 2)
  |> should.equal(order.Gt)

  collection.descending_order(2, 1)
  |> should.equal(order.Lt)
}
