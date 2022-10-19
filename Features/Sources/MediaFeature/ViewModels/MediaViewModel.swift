import Domain
import Combine
import Storage
import Networking


public class MediaDetailsViewModel: ObservableObject {
  private(set) var media: Media
  private let repository: MediaDetailsRepository
  @Published private(set) var cast: [Actor] = []
  @Published private(set) var clips: [Clip] = []
  @Published private(set) var genres: [String] = []
  @Published private(set) var trailerURLString: String?
  
  public init(media: Media, repository: MediaDetailsRepository) {
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
    self.clips = result.clips.lazy.filter { $0.site != nil && $0.site == .youtube }
    self.trailerURLString = self.clips.filter { $0.type != nil && $0.type == .trailer }.last?.key
  }
}


public struct MediaDetailsRepository {
  private let mediaType: MediaType
  private let remoteMovieDetailsDataSource: RemoteMovieDetailsDataSource
  private let remoteSeriesDetailsDataSource: RemoteSerieDetailsDataSource
  
  public init(
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


public struct LocalMediaDetailDataSource {
  static let persistence: PersistenceController = .init()
  private(set) var addMedia: (Media) async throws -> Bool
  private(set) var removeMedia: (Media) async throws -> Bool
  
  public init(
    addMedia: @escaping (Media) async throws -> Bool,
    removeMedia: @escaping (Media) async throws -> Bool
  ) {
    self.addMedia = addMedia
    self.removeMedia = removeMedia
  }
  
}


public struct RemoteMovieDetailsDataSource {
  static var client = APIClient()
  private(set) var movieDetails: (Int) async throws -> RemoteMovieDetails
  private(set) var movieCast: (Int) async throws -> CastResponse
  private(set) var movieClips: (Int) async throws -> ClipResponse
  
  public init(
    movieDetails: @escaping (Int) async throws -> RemoteMovieDetails,
    movieCast: @escaping (Int) async throws -> CastResponse,
    movieClips: @escaping (Int) async throws -> ClipResponse
  ) {
    self.movieDetails = movieDetails
    self.movieCast = movieCast
    self.movieClips = movieClips
  }
  
  public static let live = Self(
    movieDetails: { id in
      let request = Request(path: "movie/\(id)")
      return try await client.execute(request: request)
    },
    movieCast: { id in
      let request = Request(path: "movie/\(id)/credits")
      return try await client.execute(request: request)
    },
    movieClips: { id in
      let request = Request(path: "movie/\(id)/videos")
      return try await client.execute(request: request)
    }
  )
}


public struct RemoteSerieDetailsDataSource {
  static var client = APIClient()
  private(set) var serieDetails: (Int) async throws -> RemoteSerieDetails
  private(set) var serieCast: (Int) async throws -> CastResponse
  private(set) var serieClips: (Int) async throws -> ClipResponse
  
  public init(
    serieDetails: @escaping (Int) async throws -> RemoteSerieDetails,
    serieCast: @escaping (Int) async throws -> CastResponse,
    serieClips: @escaping (Int) async throws -> ClipResponse
  ) {
    self.serieDetails = serieDetails
    self.serieCast = serieCast
    self.serieClips = serieClips
  }
  
  public static let live = Self(
    serieDetails: { id in
      let request = Request(path: "tv/\(id)")
      return try await client.execute(request: request)
    },
    serieCast: { id in
      let request = Request(path: "tv/\(id)/credits")
      return try await client.execute(request: request)
    },
    serieClips: { id in
      let request = Request(path: "tv/\(id)/videos")
      return try await client.execute(request: request)
    }
  )
  
}
