import Core
import Combine
import Networking


final class MoviesViewModel: ObservableObject {
  private var repository: MovieRepository
  
  @Published var comingSoonMovies: [Movie] = []
  @Published var trendingMovies: [Movie] = []
  @Published var latestMovies: [Movie] = []
  @Published var popularMovies: [Movie] = []
  
  public init(repository: MovieRepository) {
    self.repository = repository
  }
  
  @MainActor func fetchMovies() async throws {
    async let comingSoonMovies = await repository.fetchComingSoonMovies()
    async let trendingMovies = await repository.fetchTrendingMovies()
    async let latestMovies = await repository.fetchLatestMovies()
    async let popularMovies = await repository.fetchPopularMovies()
    let result = try await (comingSoonMovies: comingSoonMovies, trendingMovies: trendingMovies, latestMovies: latestMovies, popularMovies: popularMovies)
    self.comingSoonMovies = result.comingSoonMovies.sequentially()
    self.trendingMovies = result.trendingMovies.sequentially()
    self.latestMovies = result.latestMovies.sequentially()
    self.popularMovies = result.popularMovies.sequentially()
  }
}


struct MovieRepository {
  private let remoteDataSource: RemoteMovieDataSource
  
  public init(remoteDataSource: RemoteMovieDataSource = .live) {
    self.remoteDataSource = remoteDataSource
  }
  
  func fetchComingSoonMovies() async throws -> [Movie] {
    let response = try await remoteDataSource.upcomingMovies()
    return response.results.compactMap { $0.model }
  }
  
  func fetchTrendingMovies() async throws -> [Movie] {
    let response = try await remoteDataSource.trendingMovies()
    return response.results.compactMap { $0.model }
  }
  
  func fetchLatestMovies() async throws -> [Movie] {
    let response = try await remoteDataSource.latestMovies()
    return response.results.compactMap { $0.model }
  }
  
  func fetchPopularMovies() async throws -> [Movie] {
    let response = try await remoteDataSource.popularMovies()
    return response.results.compactMap { $0.model }
  }
}


struct RemoteMovieDataSource {
  public static var client = APIClient()
  private(set) var upcomingMovies: () async throws -> MoviesResponse
  private(set) var trendingMovies: () async throws -> MoviesResponse
  private(set) var latestMovies: () async throws -> MoviesResponse
  private(set) var popularMovies: () async throws -> MoviesResponse
  
  init(
    upcomingMovies: @escaping () async throws -> MoviesResponse,
    trendingMovies: @escaping () async throws -> MoviesResponse,
    latestMovies: @escaping () async throws -> MoviesResponse,
    popularMovies: @escaping () async throws -> MoviesResponse
  ) {
    self.upcomingMovies = upcomingMovies
    self.trendingMovies = trendingMovies
    self.latestMovies = latestMovies
    self.popularMovies = popularMovies
  }
  
   public static let live = Self(
    upcomingMovies: {
      let request = Request(path: "movie/upcoming", method: .get)
      return try await client.execute(request: request)
    },
    trendingMovies: {
      let request = Request(path: "trending/all/week", method: .get)
      return try await client.execute(request: request)
    },
    latestMovies: {
      let request = Request(path: "movie/now_playing", method: .get)
      return try await client.execute(request: request)
    },
    popularMovies: {
      let request = Request(path: "movie/popular", method: .get)
      return try await client.execute(request: request)
    }
  )
}
