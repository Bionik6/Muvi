import Inject
import SwiftUI


struct MoviesView: View {
  @ObservedObject private var iO = Inject.observer
  @StateObject private var viewModel = MoviesViewModel(repository: .init())
  
  var body: some View {
    
    NavigationView {
      ScrollView {
        MediaSection(media: viewModel.comingSoonMovies, title: "Upcoming", redactedViewsNumber: 3, type: .landscape) {
          ForEach(viewModel.comingSoonMovies.prefix(8), id: \.id) { movie in
            NavigationLink(
              destination: MediaDetailsView(viewModel: MediaDetailsViewModel(media: movie, repository: .init(mediaType: .movie))),
              label: { ComingSoonCard(media: movie) }
            )
          }
        }
        
        MediaSection(media: viewModel.trendingMovies, title: "Hot Now 🔥", redactedViewsNumber: 5, type: .portrait) {
          ForEach(viewModel.trendingMovies.prefix(8), id: \.id) { movie in
            NavigationLink(
              destination: MediaDetailsView(viewModel: MediaDetailsViewModel(media: movie, repository: .init(mediaType: .movie))),
              label: { MediaCardView(media: movie) }
            )
          }
        }
        
        MediaSection(media: viewModel.latestMovies, title: "Latest Releases", redactedViewsNumber: 5, type: .portrait) {
          ForEach(viewModel.latestMovies.prefix(8), id: \.id) { movie in
            NavigationLink(
              destination: MediaDetailsView(viewModel: MediaDetailsViewModel(media: movie, repository: .init(mediaType: .movie))),
              label: { MediaCardView(media: movie) }
            )
          }
        }
        
        MediaSection(media: viewModel.popularMovies, title: "Hits Box Office", redactedViewsNumber: 5, type: .portrait) {
          ForEach(viewModel.popularMovies.prefix(8), id: \.id) { movie in
            NavigationLink(
              destination: MediaDetailsView(viewModel: MediaDetailsViewModel(media: movie, repository: .init(mediaType: .movie))),
              label: { MediaCardView(media: movie) }
            )
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
    .enableInjection()
    .eraseToAnyView()
  }
}


struct MoviesView_Previews: PreviewProvider {
  static var previews: some View {
    MoviesView()
      .preferredColorScheme(.dark)
  }
}
