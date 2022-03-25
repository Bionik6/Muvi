import Combine


class MediaDetailsViewModel: ObservableObject {
  private let repository: MediaDetailsRepository
  private(set) var media: Media
  @Published private(set) var genres: [String] = []
  @Published private(set) var cast: [Actor] = []
  @Published private(set) var clips: [Clip] = []
  
  init(media: Media, repository: MediaDetailsRepository) {
    self.media = media
    self.repository = repository
  }
  
  @MainActor func fetchAllMediaDetails() async throws {
    async let mediaDetails = await repository.fetchMediaDetails(id: media.id)
    async let cast = await repository.fetchMediaCast(id: media.id)
    async let clips = await repository.fetchMediaClips(id: media.id)
    let result = try await (mediaDetails: mediaDetails, cast: cast, clips: clips)
    self.genres = result.mediaDetails.genres
    self.cast = result.cast.lazy.filter { $0.profileImagePath != nil}.sorted { $0.order < $1.order }
    self.clips = result.clips
  }
}


struct MediaDetailsRepository {
  private let mediaType: MediaType
  private let remoteMovieDetailsDataSource: RemoteMovieDetailsDataSource
  private let remoteSeriesDetailsDataSource: RemoteSerieDetailsDataSource
  
  init(
    mediaType: MediaType,
    remoteMovieDetailsDataSource: RemoteMovieDetailsDataSource = .live,
    remoteSeriesDetailsDataSource: RemoteSerieDetailsDataSource = .live
  ) {
    self.mediaType = mediaType
    self.remoteMovieDetailsDataSource = remoteMovieDetailsDataSource
    self.remoteSeriesDetailsDataSource = remoteSeriesDetailsDataSource
  }
  
  func fetchMediaDetails(id: Int) async throws -> MediaDetails {
    switch mediaType {
      case .movie: return try await remoteMovieDetailsDataSource.movieDetails(id).model
      case .serie: return try await remoteSeriesDetailsDataSource.serieDetails(id).model
    }
  }
  
  func fetchMediaCast(id: Int) async throws -> [Actor] {
    switch mediaType {
      case .movie: return try await remoteMovieDetailsDataSource.movieCast(id).cast.compactMap { $0.model }
      case .serie: return try await remoteSeriesDetailsDataSource.serieCast(id).cast.compactMap { $0.model }
    }
  }
  
  func fetchMediaClips(id: Int) async throws -> [Clip] {
    switch mediaType {
      case .movie: return try await remoteMovieDetailsDataSource.movieClips(id).results.compactMap { $0.model }
      case .serie: return try await remoteSeriesDetailsDataSource.serieClips(id).results.compactMap { $0.model }
    }
  }
  
}


struct RemoteMovieDetailsDataSource {
  static var client = APIClient()
  private(set) var movieDetails: (Int) async throws -> RemoteMovieDetails
  private(set) var movieCast: (Int) async throws -> CastResponse
  private(set) var movieClips: (Int) async throws -> ClipResponse
  
  init(
    movieDetails: @escaping (Int) async throws -> RemoteMovieDetails,
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
