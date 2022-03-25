import SwiftUI

struct MediaDetailsView: View {
  
  @Environment(\.presentationMode) private var presentationMode
  @ObservedObject var viewModel: MediaDetailsViewModel
  
  var body: some View {
    ScrollView {
      ZStack(alignment: .bottomLeading) {
        
        AsyncImage(url: viewModel.media.largerPosterURL) { image in
          image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 500)
        } placeholder: {
          Image("spiderman")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 500)
            .redacted(reason: .placeholder)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .edgesIgnoringSafeArea(.all)
        
        LinearGradient(
          colors: [Color.black.opacity(0.4), Color.black.opacity(0)],
          startPoint: UnitPoint(x: 0.5, y: 1), endPoint: UnitPoint(x: 0.5, y: 0)
        )
        
        VStack(alignment: .leading) {
          Button(action: { presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.left")
              .font(.headline)
          }
          .padding(.top, 16)
          
          Spacer()
          
          VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.media.title).font(.heading2)
            Text(viewModel.genres.joined(separator: ", ")).padding(.all, 0)
            HStack {
              HStack(spacing: 2) {
                Image("star")
                  .resizable()
                  .frame(width: 13, height: 13)
                  .foregroundColor(.mainOrange)
                Text(viewModel.media.formatedVote)
              }
              Text("-")
              Text(viewModel.media.releaseDateYear)
            }
            .padding(.all, 0)
            
            HStack {
              OutlineButton(title: "WatchList", systemImage: "plus.square", action: {})
              PrimaryButton(title: "Play Trailer", systemImage: "play.circle", action: {})
            }.padding(.top, 12)
          }
          
        }
        .font(.body1)
        .foregroundColor(.white)
        .padding(.horizontal)
        .padding(.bottom, 16)
      }
      .frame(height: 500)
      .clipped()
      
      
      Text(viewModel.media.overview)
        .font(.body2)
        .lineSpacing(6)
        .padding(.all, 16)
      
      
    }
    .navigationTitle("")
    .navigationBarHidden(true)
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


extension UINavigationController: UIGestureRecognizerDelegate {
  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}
