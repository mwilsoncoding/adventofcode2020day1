import std/os/file

fun main() {
  haskellish()
}

private fun product( xs : list<int> ) : int {
  xs.foldl(1, fn(x,y){x * y})
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
  val len = numbers.length()
  while{ z != 2020 && xi < len } {
    x := numbers.at(xi).mbint()
    while{ z != 2020 && yi < len } {
      y := numbers.at(yi).mbint()
      while{ z != 2020 && wi < len } {
        w := numbers.at(wi).mbint()
        z := x + y + w
        wi := wi + 1
      }
      yi := yi + 1
      wi := yi + 1
    }
    xi := xi + 1
    yi := xi + 1
    wi := yi + 1
  }
  [x,y,w].product().println()
}

private fun sum-prod-outer(l : list<int>) {
  match (sum-prod-inner(2020 - l.head(0), l.tail())) {
    Just(y) -> y * l.head(0)
    Nothing -> if (l.tail().is-empty()) then 0 else sum-prod-outer(list.tail())
  }
}

private fun sum-prod-inner(n : <int>, l : list<int>) {
  val answer = l.tail().find-maybe(fn(x){ if (x == n - l.head(0)) then Just(x * (n - x)) else Nothing }
  match (answer) {
    Just(n) -> Just(n)
    Nothing -> if (l.tail().is-empty()) then Nothing else sum-prod-inner(n, l.tail())
  }
}

private fun haskellish() {
  read-text-file("./input")
    .head("")
    .lines()
    .map(fn(s){s.parse-int-default()})
    .sum-prod-outer()
    .println()
}
