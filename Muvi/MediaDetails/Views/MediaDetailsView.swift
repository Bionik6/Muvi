import SwiftUI

struct MediaDetailsView: View {
  
  @ObservedObject var viewModel: MediaDetailsViewModel
  
    var body: some View {
      VStack {
        
      }
      .navigationTitle(viewModel.media.title)
      .task {
        do {
          try await viewModel.fetchAllMediaDetails()
        } catch {
          print(error)
        }
      }
      
    }
}

struct MediaDetailsView_Previews: PreviewProvider {
    static var previews: some View {
      let movie = Movie(id: 1, title: "Batman", posterPath: "", vote: 8.3, releaseDateString: "", overview: "")
      MediaDetailsView(viewModel: MediaDetailsViewModel(media: movie, repository: MediaDetailsRepository(mediaType: .movie)))
    }
}
