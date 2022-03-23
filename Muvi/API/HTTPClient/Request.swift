import Foundation

public struct Request<T: Encodable> {
  var path: String
  var method: HTTPMethod
  var params: T?
  var headers: [String: String]?
  
  public init(path: String, method: HTTPMethod, params: T? = nil, headers: [String: String]? = nil) {
    self.path = path
    self.method = method
    self.params = params
    self.headers = headers
  }
}
