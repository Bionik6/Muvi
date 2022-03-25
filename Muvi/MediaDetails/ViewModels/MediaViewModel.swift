import Combine


class MediaDetailsViewModel: ObservableObject {
  private var media: Media
  private var repository: MediaDetailsRepository
  
  init(media: Media, repository: MediaDetailsRepository) {
    self.media = media
    self.repository = repository
  }
  
}


struct MediaDetailsRepository {
  private let remoteMovieDetailsDataSource: RemoteMovieDetailsDataSource
  private let remoteSeriesDetailsDataSource: RemoteSerieDetailsDataSource
  
  init(
    remoteMovieDetailsDataSource: RemoteMovieDetailsDataSource,
    remoteSeriesDetailsDataSource: RemoteSerieDetailsDataSource
  ) {
    self.remoteMovieDetailsDataSource = remoteMovieDetailsDataSource
    self.remoteSeriesDetailsDataSource = remoteSeriesDetailsDataSource
  }
  
}


struct RemoteMovieDetailsDataSource {
  static var client = APIClient()
  private(set) var movieDetails: (Int) async throws -> MoviesResponse
  private(set) var movieCast: (Int) async throws -> MoviesResponse
  private(set) var movieScenes: (Int) async throws -> MoviesResponse
  
//  static let live = Self(
//
//  )
}


struct RemoteSerieDetailsDataSource {
  static var client = APIClient()
  
  static let live = Self(
    
  )
}
