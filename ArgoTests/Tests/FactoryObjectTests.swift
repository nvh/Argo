import XCTest
import Argo
import Runes

struct User {
  let firstName: String
  let lastName: String
  let email: String

  static func create(firstName: String)(lastName: String)(email: String) -> User {
    return User(firstName: firstName, lastName: lastName, email: email)
  }
}

class FactoryObjectTests: XCTestCase {
  func testModelFactoryObjectParsing() {

  }
}
