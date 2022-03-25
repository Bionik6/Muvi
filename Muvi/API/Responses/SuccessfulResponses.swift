import Foundation

public protocol BackendResponse: Decodable {
  var status: Int { get }
}

struct MoviesResponse: Decodable {
  let results: [RemoteMovie]
}

struct SeriesResponse: Decodable {
  let results: [RemoteSerie]
}

struct CastResponse: Decodable {
  let cast: [RemoteActor]
}
