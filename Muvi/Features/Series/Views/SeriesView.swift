import SwiftUI

struct SeriesView: View {
  
  @StateObject private var viewModel = SeriesViewModel(repository: .init())
  
    var body: some View {
      NavigationView {
        ScrollView {
          MediaSection(media: viewModel.airingTodaySeries, title: "Airing Today", redactedViewsNumber: 3, type: .landscape) {
            ForEach(viewModel.airingTodaySeries.prefix(8), id: \.id) { serie in
              NavigationLink(
                destination: MediaDetailsView(viewModel: MediaDetailsViewModel(media: serie, repository: .init(mediaType: .serie))),
                label: { ComingSoonCard(media: serie) }
              )
            }
          }
          
          MediaSection(media: viewModel.trendingSeries, title: "Trending Now", redactedViewsNumber: 5, type: .portrait) {
            ForEach(viewModel.trendingSeries.prefix(8), id: \.id) { serie in
              NavigationLink(
                destination: MediaDetailsView(viewModel: MediaDetailsViewModel(media: serie, repository: .init(mediaType: .serie))),
                label: { MediaCardView(media: serie) }
              )
            }
          }
          
          MediaSection(media: viewModel.topRatedSeries, title: "Top Rated", redactedViewsNumber: 5, type: .portrait) {
            ForEach(viewModel.topRatedSeries.prefix(8), id: \.id) { serie in
              NavigationLink(
                destination: MediaDetailsView(viewModel: MediaDetailsViewModel(media: serie, repository: .init(mediaType: .serie))),
                label: { MediaCardView(media: serie) }
              )
            }
          }
          
          MediaSection(media: viewModel.popularSeries, title: "Hits Box Office", redactedViewsNumber: 5, type: .portrait) {
            ForEach(viewModel.popularSeries.prefix(8), id: \.id) { serie in
              NavigationLink(
                destination: MediaDetailsView(viewModel: MediaDetailsViewModel(media: serie, repository: .init(mediaType: .serie))),
                label: { MediaCardView(media: serie) }
              )
            }
          }
          
        }.task {
          do {
            try await viewModel.fetchSeries()
          } catch {
            print(error)
          }
        }.navigationTitle(Text("TV Shows"))
      }
      
        .eraseToAnyView()
    }

    #if DEBUG
    @ObservedObject var iO = injectionObserver
    #endif
}

struct SeriesView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesView()
    }
}
