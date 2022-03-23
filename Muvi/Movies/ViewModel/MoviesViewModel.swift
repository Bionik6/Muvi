import Combine
import Foundation

struct RemoteMovieDataSource {
  private let upcomingMovies: () async throws -> MoviesResponse
  private let trendingMovies: () async throws -> MoviesResponse
  private let latestMovies: () async throws -> MoviesResponse
  private let popularMovies: () async throws -> MoviesResponse
  
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
      return try await Self.make
    },
    trendingMovies: <#T##() async throws -> MoviesResponse#>,
    latestMovies: <#T##() async throws -> MoviesResponse#>,
    popularMovies: <#T##() async throws -> MoviesResponse#>
  )
}

struct MovieRepository {
  
}


extension String: Error { }

final class MoviesViewModel: ObservableObject {
  
  private var API_KEY: String {
    guard let key = Bundle.main.infoDictionary?["API_KEY"] as? String else { fatalError("api key couldn't be found") }
    return key
  }
  
  @Published var comingSoonMovies: [Movie] = []
  @Published var trendingMovies: [Movie] = []
  @Published var latestMovies: [Movie] = []
  @Published var popularMovies: [Movie] = []
  
  func fetchMovies() async throws {
    async let comingSoonMovies = await fetchComingSoonMovies()
    async let trendingMovies = await fetchTrendingMovies()
    async let latestMovies = await fetchLatestMovies()
    async let popularMovies = await fetchPopularMovies()
    let result = try await (comingSoonMovies: comingSoonMovies, trendingMovies: trendingMovies, latestMovies: latestMovies, popularMovies: popularMovies)
    self.comingSoonMovies = result.comingSoonMovies
    self.trendingMovies = result.trendingMovies
    self.latestMovies = result.latestMovies
    self.popularMovies = result.popularMovies
  }
  
  @MainActor private func fetchComingSoonMovies() async throws -> [Movie] {
    let (data, response) = try await URLSession.shared.data(from: URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(API_KEY)")!)
    if let response = response as? HTTPURLResponse {
      if response.statusCode == 401 { throw "Not Authorized" }
      if 400...599 ~= response.statusCode { throw "Something bad happens" }
    }
    guard let object = try? decoder.decode(MoviesResponse.self, from: data) else { throw "Error decoding movies" }
    return object.results.compactMap { $0.model }
  }
  
  @MainActor private func fetchTrendingMovies() async throws -> [Movie] {
    let (data, response) = try await URLSession.shared.data(from: URL(string: "https://api.themoviedb.org/3/trending/all/week?api_key=\(API_KEY)")!)
    if let response = response as? HTTPURLResponse {
      if response.statusCode == 401 { throw "Not Authorized" }
      if 400...599 ~= response.statusCode { throw "Something bad happens" }
    }
    do {
      let object = try decoder.decode(MoviesResponse.self, from: data)
      return object.results.compactMap { $0.model }
    }
  }
  
  @MainActor private func fetchLatestMovies() async throws -> [Movie] {
    let (data, response) = try await URLSession.shared.data(from: URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(API_KEY)")!)
    if let response = response as? HTTPURLResponse {
      if response.statusCode == 401 { throw "Not Authorized" }
      if 400...599 ~= response.statusCode { throw "Something bad happens" }
    }
    do {
      let object = try decoder.decode(MoviesResponse.self, from: data)
      return object.results.compactMap { $0.model }
    }
  }
  
  @MainActor private func fetchPopularMovies() async throws -> [Movie] {
    let (data, response) = try await URLSession.shared.data(from: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(API_KEY)&page=1")!)
    if let response = response as? HTTPURLResponse {
      if response.statusCode == 401 { throw "Not Authorized" }
      if 400...599 ~= response.statusCode { throw "Something bad happens" }
    }
    do {
      let object = try decoder.decode(MoviesResponse.self, from: data)
      return object.results.compactMap { $0.model }
    }
  }
  
  private var decoder: JSONDecoder {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }
  
}
