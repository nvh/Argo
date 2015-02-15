import Runes
import Box

func sequence<T>(xs: [T?]) -> [T]? {
  return reduce(xs, []) { accum, elem in
    return curry(+) <^> accum <*> (pure <^> elem)
  }
}

func sequence<T>(xs: [JSONResult<T>]) -> JSONResult<[T]> {
  return reduce(xs, .Success(Box([]))) { accum, elem in
    return curry(+) <^> accum <*> (pure <^> elem)
  }
}

func sequence<T>(xs: [JSONResult<T>]) -> JSONResult<[T]> {
  return reduce(xs, .Success([])) { accum, elem in
    return curry(+) <^> accum <*> (pure <^> elem)
  }
}
