import std/os/file
import std/os/path
import std/os/env

effect<a> control yield( item : a ) : ()
effect<a> control yield-peek( item : a, rest : list<a> ) : ()

fun iterate-peek(xs : list<a> ) : yield-peek<a> () {
  match(xs) {
    Nil -> ()
    Cons(x,xx) -> { yield-peek(x, xx); iterate-peek(xx) }
  }
}

fun iterate(xs : list<a> ) : yield<a> () {
  match(xs) {
    Nil -> ()
    Cons(x,xx) -> { yield(x); iterate(xx) }
  }
}

private fun applyUntilFalse(f : a -> e bool, action : () -> <yield<a>|e> ()) : e () {
  with control yield(x) { if (f(x)) then resume(()) else () }
  action()
}

private fun applyUntilFalse-peek(f : (a, list<a>) -> e bool, action : () -> <yield-peek<a>|e> ()) : e () {
  with control yield-peek(x, xx) { if (f(x, xx)) then resume(()) else () }
  action()
}

private fun product(xs: list<int>) {
  xs.foldl( 1, fn(x,y) { x * y } )
}

fun main() {
  var s := 0
  applyUntilFalse-peek fn(x:int, inner:list<int>) {
    applyUntilFalse-peek fn(y:int, rest: list<int>) {
      applyUntilFalse fn(z:int) {
        s := [x, y, z].sum
        val continue = s != 2020
        if (continue) then () else [x, y, z].product().println
        continue
      }
      { rest.iterate }
      s != 2020
    }
    { inner.iterate-peek }
    s != 2020
  }
  {
    get-env("INPUT_FILE_NAME")
      .maybe("")
      .realpath()
      .read-text-file()
      .lines()
      .init() // input ends in a newline
      .map(fn(s){s.parse-int-default()}).iterate-peek
  }
}
