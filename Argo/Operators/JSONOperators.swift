import Runes

// MARK: Values

// Pull embedded value from JSON
public func <|<A: JSONDecodable>(json: JSONValue, keys: [String]) -> A.DecodedType? {
  if let o = json.find(keys) {
    return A.decode(o)
  }

  return .None
}

// Pull value from JSON
public func <|<A: JSONDecodable>(json: JSONValue, key: String) -> A.DecodedType? {
  return json <| [key]
}

// Pull embedded optional value from JSON
public func <|?<A: JSONDecodable>(json: JSONValue, keys: [String]) -> A.DecodedType?? {
  return pure(json <| keys)
}

// Pull optional value from JSON
public func <|?<A: JSONDecodable>(json: JSONValue, key: String) -> A.DecodedType?? {
  return json <|? [key]
}

// MARK: Arrays

// Pull embedded array from JSON
public func <||<A: JSONDecodable>(json: JSONValue, keys: [String]) -> [A.DecodedType]? {
  return json.find(keys) >>- JSONValue.mapDecode
}

// Pull array from JSON
public func <||<A: JSONDecodable>(json: JSONValue, key: String) -> [A.DecodedType]? {
  return json <|| [key]
}


// Pull embedded optional array from JSON
public func <||?<A: JSONDecodable>(json: JSONValue, keys: [String]) -> [A.DecodedType]?? {
  return pure(json <|| keys)
}

// Pull optional array from JSON
public func <||?<A: JSONDecodable>(json: JSONValue, key: String) -> [A.DecodedType]?? {
  return json <||? [key]
}
