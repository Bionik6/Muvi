import Foundation

public struct MoviesResponse: Decodable {
  public let results: [RemoteMovie]
}

public struct SeriesResponse: Decodable {
  public let results: [RemoteSerie]
}

public struct CastResponse: Decodable {
  public let cast: [RemoteActor]
}

public struct ClipResponse: Decodable {
  public let results: [RemoteClip]
}
