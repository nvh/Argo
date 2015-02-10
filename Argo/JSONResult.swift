//
//  JSONResult.swift
//  Argo
//
//  Created by Niels van Hoorn on 03/02/15.
//  Copyright (c) 2015 thoughtbot. All rights reserved.
//

import Foundation
import Runes

let ArgoErrorDomain = "ArgoErrorDomain"

public enum JSONResult<T> {
  case Success(@autoclosure() -> T)
  case Failure(NSError)
}

//MARK: convenience constructors and getters
extension JSONResult {
  public init(errorMessage message: String) {
    self = .Failure(NSError(domain: ArgoErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey:message]))
  }
  
  public init(optional: T?, errorMessage: String? = nil) {
    if let value = optional {
      self = .Success(value)
    } else {
      let message = errorMessage ?? "Constructing JSONResult from nil value"
      let error = NSError(domain: ArgoErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey:message])
      self = .Failure(error)
    }
  }
  
  public var error: NSError? {
    switch self {
    case let .Failure(error):
      return error
    default:
      return nil
    }
  }
  public var value: T? {
    switch self {
    case let .Success(value):
      return value()
    default:
      return nil
    }
  }
}

extension JSONResult: Printable {
    public var description: String {
        switch self {
        case .Success(let value):
            return "Success: \(value())"
        case .Failure(let error):
            return "Failure: \(error.localizedDescription)"
        }
    }
    
}

//MARK: JSONValue extension
public extension JSONValue {
  static func mapDecode<A where A: JSONResultDecodable, A == A.DecodedResultType>(value: JSONValue) -> JSONResult<[A]> {
    switch value {
    case let .JSONArray(a): return sequence(a.map { A.decodeResult($0) })
    default: return JSONResult(errorMessage: "Unable to mapDecode \(self)")
    }
  }
}

public extension JSONValue {
  func value<A>() -> JSONResult<A> {
    return JSONResult(optional: self.value(), errorMessage: "No value present in \(self)")
  }
    
  subscript(key: String) -> JSONResult<JSONValue> {
    return JSONResult(optional: self[key], errorMessage: "Key '\(key)' not found in \(self)")
  }
    
  func find(keys: [String]) -> JSONResult<JSONValue> {
    return JSONResult(optional: find(keys), errorMessage: "Keys '\(keys)' not found in \(self)")
  }
}


//MARK: Runes
public func <^><T, U>(f: T -> U, a: JSONResult<T>) -> JSONResult<U> {
  return a.map(f)
}

public func <*><T, U>(f: JSONResult<T -> U>, a: JSONResult<T>) -> JSONResult<U> {
  return a.apply(f)
}

public func >>-<T, U>(a: JSONResult<T>, f: T -> JSONResult<U>) -> JSONResult<U> {
  return a.flatMap(f)
}

public func pure<T>(a: T) -> JSONResult<T> {
  return .Success(a)
}

extension JSONResult {
  func map<U>(f: (T) -> U) -> JSONResult<U> {
    switch self {
    case .Success(let x): return .Success(f(x()))
    case .Failure(let error): return .Failure(error)
    }
  }
  
  func apply<U>(f: JSONResult<T -> U>) -> JSONResult<U> {
    switch (self, f) {
    case (.Success(let x),.Success(let fx)): return .Success(fx()(x()))
    case (.Failure(let error),_): return .Failure(error)
    case (_,.Failure(let error)): return .Failure(error)
    default:
      return JSONResult<U>(errorMessage: "Unknown error")
    }
  }
    
  func flatMap<U>(f: T -> JSONResult<U>) -> JSONResult<U> {
    switch self {
    case .Success(let x): return f(x())
    case .Failure(let error): return .Failure(error)
    }
  }
}
