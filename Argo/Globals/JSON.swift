import Foundation

//MARK: JSONDecodable
extension String: JSONDecodable {
  public static func decode(j: JSONValue) -> String? {
    return j.value()
  }
}

extension Int: JSONDecodable {
  public static func decode(j: JSONValue) -> Int? {
    return j.value()
  }
}

extension Double: JSONDecodable {
  public static func decode(j: JSONValue) -> Double? {
    return j.value()
  }
}

extension Bool: JSONDecodable {
  public static func decode(j: JSONValue) -> Bool? {
    return j.value()
  }
}

//MARK: JSONResultDecodable
func makeResultDecodable<A:JSONDecodable>(f: JSONValue -> A?, j: JSONValue) -> JSONResult<A> {
    return JSONResult(optional: f(j))
}

extension String: JSONResultDecodable {
  public static func decodeResult(j: JSONValue) -> JSONResult<String> {
    return makeResultDecodable(String.decode,j)
  }
}

extension Int: JSONResultDecodable {
  public static func decodeResult(j: JSONValue) -> JSONResult<Int> {
    return makeResultDecodable(Int.decode,j)
  }
}

extension Double: JSONResultDecodable {
  public static func decodeResult(j: JSONValue) -> JSONResult<Double> {
    return makeResultDecodable(Double.decode,j)
  }
}

extension Bool: JSONResultDecodable {
  public static func decodeResult(j: JSONValue) -> JSONResult<Bool> {
    return makeResultDecodable(Bool.decode,j)
  }
}