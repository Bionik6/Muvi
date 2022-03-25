import Combine


class MediaDetailsViewModel: ObservableObject {
  private let mediaType: MediaType
  private let repository: MediaDetailsRepository
  
  init(mediaType: MediaType, repository: MediaDetailsRepository) {
    self.mediaType = mediaType
    self.repository = repository
  }
  
}


struct MediaDetailsRepository {
  private let mediaType: MediaType
  private let remoteMovieDetailsDataSource: RemoteMovieDetailsDataSource
  private let remoteSeriesDetailsDataSource: RemoteSerieDetailsDataSource
  
  init(
    mediaType: MediaType,
    remoteMovieDetailsDataSource: RemoteMovieDetailsDataSource,
    remoteSeriesDetailsDataSource: RemoteSerieDetailsDataSource
  ) {
    self.mediaType = mediaType
    self.remoteMovieDetailsDataSource = remoteMovieDetailsDataSource
    self.remoteSeriesDetailsDataSource = remoteSeriesDetailsDataSource
  }
  
}


struct RemoteMovieDetailsDataSource {
  static var client = APIClient()
  private(set) var movieDetails: (Int) async throws -> RemoteMovie
  private(set) var movieCast: (Int) async throws -> CastResponse
  private(set) var movieClips: (Int) async throws -> ClipResponse
  
  init(
    movieDetails: @escaping (Int) async throws -> RemoteMovie,
    movieCast: @escaping (Int) async throws -> CastResponse,
    movieClips: @escaping (Int) async throws -> ClipResponse
  ) {
    self.movieDetails = movieDetails
    self.movieCast = movieCast
    self.movieClips = movieClips
  }
  
  static let live = Self(
    movieDetails: { id in
      let request = Request(path: "movie/\(id)", method: .get)
      return try await client.execute(request: request)
    },
    movieCast: { id in
      let request = Request(path: "movie/\(id)/credits", method: .get)
      return try await client.execute(request: request)
    },
    movieClips: { id in
      let request = Request(path: "movie/\(id)/videos", method: .get)
      return try await client.execute(request: request)
    }
  )
}


struct RemoteSerieDetailsDataSource {
  static var client = APIClient()
  private(set) var serieDetails: (Int) async throws -> RemoteSerieDetails
  private(set) var serieCast: (Int) async throws -> CastResponse
  private(set) var serieClips: (Int) async throws -> ClipResponse
  
  init(
    serieDetails: @escaping (Int) async throws -> RemoteSerieDetails,
    serieCast: @escaping (Int) async throws -> CastResponse,
    serieClips: @escaping (Int) async throws -> ClipResponse
  ) {
    self.serieDetails = serieDetails
    self.serieCast = serieCast
    self.serieClips = serieClips
  }
  
  static let live = Self(
    serieDetails: { id in
      let request = Request(path: "tv/\(id)", method: .get)
      return try await client.execute(request: request)
    },
    serieCast: { id in
      let request = Request(path: "tv/\(id)/credits", method: .get)
      return try await client.execute(request: request)
    },
    serieClips: { id in
      let request = Request(path: "tv/\(id)/videos", method: .get)
      return try await client.execute(request: request)
    }
  )
  
}
