import SwiftUI
import Navigation
import DesignSystem
import MediaDetails


public struct SeriesView: View {
  @Environment(\.router) var router
  @StateObject private var viewModel = SeriesViewModel(repository: .init())
  
  public init() { }
  
  public var body: some View {
    NavigationView {
      ScrollView {
        
        MediaSection(media: viewModel.airingTodaySeries, title: "Airing Today", redactedViewsNumber: 3, type: .landscape) {
          ForEach(viewModel.airingTodaySeries.prefix(8), id: \.id) { serie in
            NavigationLink(
              destination: router.resolve(path: "/media-details")
                .environmentObject(MediaDetailsViewModel(media: serie, repository: .init(mediaType: .serie))),
              label: { MediaCardView(media: serie) }
            )
          }
        }
        
        MediaSection(media: viewModel.trendingSeries, title: "Trending Now", redactedViewsNumber: 5, type: .portrait) {
          ForEach(viewModel.trendingSeries.prefix(8), id: \.id) { serie in
            NavigationLink(
              destination: router.resolve(path: "/media-details")
                .environmentObject(MediaDetailsViewModel(media: serie, repository: .init(mediaType: .serie))),
              label: { MediaCardView(media: serie) }
            )
          }
        }
        
        MediaSection(media: viewModel.topRatedSeries, title: "Top Rated", redactedViewsNumber: 5, type: .portrait) {
          ForEach(viewModel.topRatedSeries.prefix(8), id: \.id) { serie in
            NavigationLink(
              destination: router.resolve(path: "/media-details")
                .environmentObject(MediaDetailsViewModel(media: serie, repository: .init(mediaType: .serie))),
              label: { MediaCardView(media: serie) }
            )
          }
        }
        
        MediaSection(media: viewModel.popularSeries, title: "Hits Box Office", redactedViewsNumber: 5, type: .portrait) {
          ForEach(viewModel.popularSeries.prefix(8), id: \.id) { serie in
            NavigationLink(
              destination: router.resolve(path: "/media-details")
                .environmentObject(MediaDetailsViewModel(media: serie, repository: .init(mediaType: .serie))),
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
    
  }
}

struct SeriesView_Previews: PreviewProvider {
  static var previews: some View {
    SeriesView()
  }
}
