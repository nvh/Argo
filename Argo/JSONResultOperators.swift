import Runes


infix operator <-| { associativity left precedence 150 }
infix operator <-|? { associativity left precedence 150 }
infix operator <-|| { associativity left precedence 150 }
infix operator <-||? { associativity left precedence 150 }

// MARK: Values

// Pull embedded value from JSON
public func <-|<A where A: JSONResultDecodable, A == A.DecodedResultType>(json: JSONValue, keys: [String]) -> JSONResult<A> {
  if let o = json.find(keys) {
    return A.decodeResult(o)
  }
  return JSONResult(errorMessage: "keys: \(keys) not found in \(json)")
}

// Pull value from JSON
public func <-|<A where A: JSONResultDecodable, A == A.DecodedResultType>(json: JSONValue, key: String) -> JSONResult<A> {
  return json <-| [key]
}

// Pull embedded optional value from JSON
public func <-|?<A where A: JSONResultDecodable, A == A.DecodedResultType>(json: JSONValue, keys: [String]) -> JSONResult<A?> {
  let result: JSONResult<A> = json <-| keys
  return result.map(pure)
}
//
//// Pull optional value from JSON
public func <-|?<A where A: JSONResultDecodable, A == A.DecodedResultType>(json: JSONValue, key: String) -> JSONResult<A?> {
  return json <-|? [key]
}
//
//// MARK: Arrays
//
//// Pull embedded array from JSON
public func <-||<A where A: JSONResultDecodable, A == A.DecodedResultType>(json: JSONValue, keys: [String]) -> JSONResult<[A]> {
  return json.find(keys) >>- JSONValue.mapDecode
}
//
//// Pull array from JSON
public func <-||<A where A: JSONResultDecodable, A == A.DecodedResultType>(json: JSONValue, key: String) -> JSONResult<[A]> {
  return json <-|| [key]
}

// Pull embedded optional array from JSON
public func <-||?<A where A: JSONResultDecodable, A == A.DecodedResultType>(json: JSONValue, keys: [String]) -> JSONResult<[A]?> {
  let result: JSONResult<[A]> = json <-|| keys
  return result.map(pure)
}

//// Pull optional array from JSON
public func <-||?<A where A: JSONResultDecodable, A == A.DecodedResultType>(json: JSONValue, key: String) -> JSONResult<[A]?> {
  return json <-||? [key]
}
