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

extension Float: JSONDecodable {
  public static func decode(j: JSONValue) -> Float? {
    return j.value()
  }
}

//MARK: JSONEncodable
extension String: JSONEncodable {
  public func encode() -> JSONValue {
    return .JSONString(self)
  }
}

extension Int: JSONEncodable {
  public func encode() -> JSONValue {
    return .JSONNumber(self)
  }
}

extension Double: JSONEncodable {
  public func encode() -> JSONValue {
    return .JSONNumber(self)
  }
}

extension Bool: JSONEncodable {
  public func encode() -> JSONValue {
    return .JSONNumber(self)
  }
}