import XCTest
import Argo
import Runes

class JSONResultTests: XCTestCase {
  

  func testJSONResultWithRootObject() {
    let json: JSONValue? = JSONValue.parse <^> JSONFileReader.JSON(fromFile: "root_object")
    let jsonResult: JSONResult<JSONValue> = JSONResult(optional: json)
    let userResult: JSONResult<User> = jsonResult >>- { $0["user"] >>- User.decodeResult }
    let user = userResult.value
    XCTAssert(user != nil)
    XCTAssert(user?.id == 1)
    XCTAssert(user?.name == "Cool User")
    XCTAssert(user?.email != nil)
    XCTAssert(user?.email! == "u.cool@example.com")
  }
}