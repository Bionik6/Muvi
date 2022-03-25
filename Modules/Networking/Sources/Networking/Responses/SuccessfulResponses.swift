import Foundation

struct MoviesResponse: Decodable {
  let results: [RemoteMovie]
}

struct SeriesResponse: Decodable {
  let results: [RemoteSerie]
}

struct CastResponse: Decodable {
  let cast: [RemoteActor]
}

struct ClipResponse: Decodable {
  let results: [RemoteClip]
}
