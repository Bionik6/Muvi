import Combine
import SwiftUI

extension String: Error { }

final class MoviesViewModel: ObservableObject {
  
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
    let (data, response) = try await URLSession.shared.data(from: URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=6af44fa099a2a0b65cabbcdac0236571")!)
    if let response = response as? HTTPURLResponse {
      if response.statusCode == 401 { throw "Not Authorized" }
      if 400...599 ~= response.statusCode { throw "Something bad happens" }
    }
    guard let object = try? decoder.decode(MoviesResponse.self, from: data) else { throw "Error decoding movies" }
    return object.results.compactMap { $0.model }
  }
  
  @MainActor private func fetchTrendingMovies() async throws -> [Movie] {
    let (data, response) = try await URLSession.shared.data(from: URL(string: "https://api.themoviedb.org/3/trending/all/week?api_key=6af44fa099a2a0b65cabbcdac0236571")!)
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
    let (data, response) = try await URLSession.shared.data(from: URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=6af44fa099a2a0b65cabbcdac0236571")!)
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
    let (data, response) = try await URLSession.shared.data(from: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=6af44fa099a2a0b65cabbcdac0236571&page=1")!)
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
    decoder.dateDecodingStrategy = .deferredToDate
    return decoder
  }
  
}

enum CardType {
  case landscape
  case portrait
}

struct MoviesView: View {
  @StateObject private var viewModel = MoviesViewModel()
  
  var body: some View {
    
    NavigationView {
      ScrollView {
        MOVIE_SECTION(for: viewModel.comingSoonMovies, title: "Coming Soon", redactedViewNumber: 3, type: .landscape) {
          ForEach(viewModel.comingSoonMovies.prefix(6), id: \.id) { movie in
            ComingSoonMovieView(movie: movie)
          }
        }
        
        MOVIE_SECTION(for: viewModel.trendingMovies, title: "Trending Now", redactedViewNumber: 5, type: .portrait) {
          ForEach(viewModel.trendingMovies.prefix(6), id: \.id) { movie in
            MovieCard(movie: movie)
          }
        }
        
        MOVIE_SECTION(for: viewModel.latestMovies, title: "Latest Releases", redactedViewNumber: 5, type: .portrait) {
          ForEach(viewModel.latestMovies.prefix(6), id: \.id) { movie in
            MovieCard(movie: movie)
          }
        }
        
        MOVIE_SECTION(for: viewModel.popularMovies, title: "Hits Box Office", redactedViewNumber: 5, type: .portrait) {
          ForEach(viewModel.popularMovies.prefix(6), id: \.id) { movie in
            MovieCard(movie: movie)
          }
        }
        /* MOVIE_SECTION(for: viewModel.comingSoonMovies, title: "Coming Soon", content: {
          ForEach(viewModel.comingSoonMovies.prefix(6), id: \.id) { movie in
            ComingSoonMovieView(movie: movie)
          }
        }, redaction: {
          ComingSoonMovieView(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
          ComingSoonMovieView(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
        }) */
      
        /* MOVIE_SECTION(for: viewModel.comingSoonMovies, title: "Trending Now", content: {
          ForEach(viewModel.trendingMovies.prefix(6), id: \.id) { movie in
            MovieCard(movie: movie)
          }
        }, redactedView: {
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
        })
        
        MOVIE_SECTION(for: viewModel.latestMovies, title: "Latest Release", content: {
          ForEach(viewModel.latestMovies.prefix(6), id: \.id) { movie in
            MovieCard(movie: movie)
          }
        }, redactedView: {
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
        })
        
        MOVIE_SECTION(for: viewModel.popularMovies, title: "Hits Box Office", content: {
          ForEach(viewModel.popularMovies.prefix(6), id: \.id) { movie in
            MovieCard(movie: movie)
          }
        }, redactedView: {
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
          MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: ""))
        }) */
        
      }.task {
        do {
          try await viewModel.fetchMovies()
        } catch {
          print(error)
        }
      }.navigationTitle(Text("Movies"))
    }
  }
  
  func MOVIE_SECTION<Content: View>(
    for movies: [Movie],
    title: String,
    redactedViewNumber: Int,
    type: CardType,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    
    Section(content: {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 16) {
          if movies.count == 0 {
            ForEach(0 ..< redactedViewNumber, id: \.self) { idx in
              if type == .landscape {
                ComingSoonMovieView(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: "")).redacted(reason: .placeholder)
              } else {
                MovieCard(movie: Movie(id: 1, title: "Hello Spidey", posterPath: "", voteAverage: 8.0, overview: "")).redacted(reason: .placeholder)
              }
            }
          } else {
            content()
          }
        }
        .padding(.leading)
        .padding(.bottom, 24)
      }
    }, header: {
      HeaderView(title: title)
    })
    
    /* return VStack {
      if movies.count == 0 {
        Section(content: {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
              redactedView()
            }
            .padding(.leading)
            .padding(.bottom, 24)
          }
        }, header: {
          HEADER_VIEW
        }).redacted(reason: .placeholder)
      } else {
        Section(content: {
          ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
              content()
            }
            .padding(.leading)
            .padding(.bottom, 24)
          }
        }, header: {
          HEADER_VIEW
        })
      }
    }*/
  }
  
}

struct HeaderView: View {
  var title: String
  
  var body: some View {
    HStack {
      Text(title)
        .font(.heading2)
      Spacer()
      Button {
      } label: {
        HStack(spacing: 6) {
          Text("See All").foregroundColor(.accentColor).font(.button)
          Image(systemName: "chevron.right").foregroundColor(.accentColor).font(.caption)
        }
        
      }
    }.padding(.horizontal)
  }
}


struct MoviesView_Previews: PreviewProvider {
  static var previews: some View {
    MoviesView()
      .preferredColorScheme(.dark)
  }
}
