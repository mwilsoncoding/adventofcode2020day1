import std/os/env

fun main() {
  imperativo()
}

private fun imperativo() {
  var numbers := get-args().head("").lines().map(fn(s){s.parse-int-default()}).vector()
  var xi := 0
  var yi := xi + 1
  var wi := yi + 1
  var z := 0
  var x := numbers.at(xi).mbint()
  var y := numbers.at(yi).mbint()
  var w := numbers.at(wi).mbint()
  while{ z != 2020 && xi < numbers.length() } {
    x := numbers.at(xi).mbint()
    while{ z != 2020 && yi < numbers.length() } {
      y := numbers.at(yi).mbint()
      while{ z != 2020 && wi < numbers.length() } {
        w := numbers.at(wi).mbint()
        z := x + y + w
        wi := wi + 1
      }
      yi := yi + 1
    }
    xi := xi + 1
  }
  (x * y * z).println()
}

fun haskellish() {
  get-args()
    .head("")
    .lines()
    .map(fn(s){s.parse-int-default()})
    .map-peek(fn(value, rest){ rest.map-peek(fn(value2, rest2){ rest2.map(fn(value3){ (value, value2, value3, value + value2 + value3) }) }) })
    .flatmap(id).flatmap(id)
    .filter-map(fn(tup){ match(tup){ (x, y, z, 2020) -> Just(x * y * z); _ -> Nothing }})
    .head(0)
    .println()
}
