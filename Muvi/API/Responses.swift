import Foundation

public protocol BackendResponse: Decodable {
  var status: Int { get }
}

struct MoviesResponse: Decodable {
  let results: [RemoteMovie]
}
