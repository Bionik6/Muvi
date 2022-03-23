import Foundation

public struct Request {
  var path: String
  var method: HTTPMethod
  var params: (() -> any Encodable)?
  var headers: [String: String]?
  
  init(path: String, method: HTTPMethod, params: (() -> any Encodable)? = nil, headers: [String : String]? = nil) {
    self.path = path
    self.method = method
    self.params = params
    self.headers = headers
  }
}
