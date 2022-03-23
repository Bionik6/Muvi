import Combine
import SwiftUI

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
          ForEach(viewModel.comingSoonMovies.prefix(8), id: \.id) { movie in
            ComingSoonMovieView(movie: movie)
          }
        }
        
        MOVIE_SECTION(for: viewModel.trendingMovies, title: "Trending Now", redactedViewNumber: 5, type: .portrait) {
          ForEach(viewModel.trendingMovies.prefix(8), id: \.id) { movie in
            MovieCardView(movie: movie)
          }
        }
        
        MOVIE_SECTION(for: viewModel.latestMovies, title: "Latest Releases", redactedViewNumber: 5, type: .portrait) {
          ForEach(viewModel.latestMovies.prefix(8), id: \.id) { movie in
            MovieCardView(movie: movie)
          }
        }
        
        MOVIE_SECTION(for: viewModel.popularMovies, title: "Hits Box Office", redactedViewNumber: 5, type: .portrait) {
          ForEach(viewModel.popularMovies.prefix(8), id: \.id) { movie in
            MovieCardView(movie: movie)
          }
        }
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
            ForEach(0..<redactedViewNumber, id: \.self) { idx in
              if type == .landscape { RedactedComingSoonMovieView() } else { RedactedMovieCardView() }
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
