import Core
import SwiftUI
import DesignSystem
import YouTubePlayerKit

public struct MediaDetailsView: View {
  
  @State private var selection: Int = 1
  @State private var playTrailer: Bool = false
  @State private var selectedClip: Clip? = nil
  @ObservedObject var viewModel: MediaDetailsViewModel
  @Environment(\.presentationMode) private var presentationMode
  var castItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
  var clipItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
  var playerConfiguration: YouTubePlayer.Configuration {
    var configuration = YouTubePlayer.Configuration()
    configuration.autoPlay = true
    configuration.allowsPictureInPictureMediaPlayback = true
    configuration.playInline = true
    return configuration
  }
  
  
  public init(viewModel: MediaDetailsViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
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
              PrimaryButton(title: "Play Trailer", systemImage: "play.circle", action: { playTrailer.toggle() })
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
      
      
      Picker("", selection: self.$selection) {
        Text("Cast").tag(1)
        Text("Clips").tag(2)
      }
      .pickerStyle(.segmented)
      .padding(.horizontal, 16)
      
      VStack {
        switch selection {
          case 1:
            ScrollView {
              LazyVGrid(columns: castItemLayout, spacing: 20) {
                ForEach(viewModel.cast, id: \.id) { cast in
                  ActorView(actor: cast)
                }
              }
            }.padding(.top, 16)
          case 2:
            if viewModel.clips.count == 0 {
              VStack {
                Image("no-clip")
                Text("No clip found.")
                  .font(.heading2)
                  .foregroundColor(.white)
              }.padding(.vertical, 30)
            } else {
              ScrollView {
                LazyVGrid(columns: clipItemLayout, spacing: 20) {
                  ForEach(viewModel.clips, id: \.name) { clip in
                    Button {
                      self.selectedClip = clip
                    } label: { ClipView(clip: clip) }
                      .foregroundColor(.white)
                  }
                }
              }.padding(.top, 16)
            }
          default: EmptyView()
        }
      }.padding(.horizontal, 16)
    }
    .navigationTitle("")
    .navigationBarHidden(true)
    .sheet(isPresented: $playTrailer, content: {
      if let youtubeLink = viewModel.trailerURLString {
        YouTubePlayerView(YouTubePlayer(source: .video(id: youtubeLink), configuration: playerConfiguration))
      }
    })
    .sheet(item: $selectedClip, onDismiss: { selectedClip = nil }, content: { clip in
      YouTubePlayerView(YouTubePlayer(source: .video(id: clip.key), configuration: playerConfiguration))
    })
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
