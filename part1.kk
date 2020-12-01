import std/os/env

fun main() {
  imperativo()
}

private fun imperativo() {
  var numbers := get-args().head("").lines().map(fn(s){s.parse-int-default()}).vector()
  var xi := 0
  var yi := xi + 1
  var z := 0
  var x := numbers.at(xi).mbint()
  var y := numbers.at(yi).mbint()
  while{ z != 2020 && xi < numbers.length() } {
    x := numbers.at(xi).mbint()
    while{ z != 2020 && yi < numbers.length() } {
      y := numbers.at(yi).mbint()
      z := x + y
      yi := yi + 1
    }
    xi := xi + 1
  }
  (x * y).println()
}

private fun haskellish() {
  get-args()
    .head("")
    .lines()
    .map(fn(s){s.parse-int-default()})
    .map-peek(fn(value, rest){ rest.map(fn(value2){ (value, value2, value + value2) }) })
    .flatmap(id)
    .filter-map(fn(tup){ match(tup){ (x, y, 2020) -> Just(x * y); _ -> Nothing }})
    .head(0)
    .println()
}
