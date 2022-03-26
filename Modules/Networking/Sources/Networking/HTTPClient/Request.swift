import Foundation

public struct Request {
  let path: String
  let method: HTTPMethod
  let params: (() -> any Encodable)?
  let headers: [String: String]?
  
  public init(path: String, method: HTTPMethod, params: (() -> any Encodable)? = nil, headers: [String : String]? = nil) {
    self.path = path
    self.method = method
    self.params = params
    self.headers = headers
  }
}
