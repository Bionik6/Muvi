import Combine
import Foundation

final class SeriesViewModel: ObservableObject {
  private var repository: SerieRepository
  
  @Published var airingTodaySeries: [Serie] = []
  @Published var trendingSeries: [Serie] = []
  @Published var topRatedSeries: [Serie] = []
  @Published var popularSeries: [Serie] = []
  
  public init(repository: SerieRepository) {
    self.repository = repository
  }
  
  @MainActor func fetchSeries() async throws {
    async let airingTodaySeries = await repository.fetchAiringTodaySeries()
    async let trendingSeries = await repository.fetchTrendingSeries()
    async let topRatedSeries = await repository.fetchTopRatedSeries()
    async let popularSeries = await repository.fetchPopularMovies()
    let result = try await (airingTodaySeries: airingTodaySeries, trendingSeries: trendingSeries, topRatedSeries: topRatedSeries, popularSeries: popularSeries)
    self.airingTodaySeries = result.airingTodaySeries.lazy.sorted { $0.releaseDate > $1.releaseDate }
    self.trendingSeries = result.trendingSeries.lazy.sorted { $0.releaseDate > $1.releaseDate }
    self.topRatedSeries = result.topRatedSeries.lazy.sorted { $0.releaseDate > $1.releaseDate }
    self.popularSeries = result.popularSeries.lazy.sorted { $0.releaseDate > $1.releaseDate }
  }
}


struct SerieRepository {
  private let remoteDataSource: RemoteSerieDataSource
  
  public init(remoteDataSource: RemoteSerieDataSource = .live) {
    self.remoteDataSource = remoteDataSource
  }
  
  func fetchAiringTodaySeries() async throws -> [Serie] {
    let response = try await remoteDataSource.airingTodaySeries()
    return response.results.compactMap { $0.model }
  }
  
  func fetchTrendingSeries() async throws -> [Serie] {
    let response = try await remoteDataSource.trendingSeries()
    return response.results.compactMap { $0.model }
  }
  
  func fetchTopRatedSeries() async throws -> [Serie] {
    let response = try await remoteDataSource.topRatedSeries()
    return response.results.compactMap { $0.model }
  }
  
  func fetchPopularMovies() async throws -> [Serie] {
    let response = try await remoteDataSource.popularSeries()
    return response.results.compactMap { $0.model }
  }
  
}


struct RemoteSerieDataSource {
  public static var client = APIClient()
  
  private(set) var airingTodaySeries: () async throws -> SeriesResponse
  private(set) var trendingSeries: () async throws -> SeriesResponse
  private(set) var topRatedSeries: () async throws -> SeriesResponse
  private(set) var popularSeries: () async throws -> SeriesResponse
  
  public init(
    airingTodaySeries: @escaping () async throws -> SeriesResponse,
    trendingSeries: @escaping () async throws -> SeriesResponse,
    topRatedSeries: @escaping () async throws -> SeriesResponse,
    popularSeries: @escaping () async throws -> SeriesResponse
  ) {
    self.airingTodaySeries = airingTodaySeries
    self.trendingSeries = trendingSeries
    self.topRatedSeries = topRatedSeries
    self.popularSeries = popularSeries
  }
  
  public static let live = Self(
    airingTodaySeries: {
      let request = Request(path: "tv/airing_today", method: .get)
      return try await client.execute(request: request)
    },
    trendingSeries: {
      let request = Request(path: "trending/tv/week", method: .get)
      return try await client.execute(request: request)
    },
    topRatedSeries: {
      let request = Request(path: "tv/top_rated", method: .get)
      return try await client.execute(request: request)
    },
    popularSeries: {
      let request = Request(path: "tv/popular", method: .get)
      return try await client.execute(request: request)
    }
  )
  
}
