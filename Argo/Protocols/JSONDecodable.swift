public protocol JSONDecodable {
  typealias DecodedType = Self
  static func decode(JSONValue) -> DecodedType?
}

public protocol JSONResultDecodable: JSONDecodable {
  typealias DecodedResultType = Self
  class func decodeResult(JSONValue) -> JSONResult<DecodedResultType>
}
