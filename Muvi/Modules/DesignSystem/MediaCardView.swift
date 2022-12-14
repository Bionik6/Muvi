import SwiftUI
import Inject

struct MediaCardView: View {
  @ObservedObject private var iO = Inject.observer
  
  private var media: Media
  
  init(media: Media) {
    self.media = media
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      
      AsyncImage(url: media.posterURL) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 152, height: 204)
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
      } placeholder: {
        Image("spiderman")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 152, height: 204)
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          .redacted(reason: .placeholder)
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text(media.title)
          .foregroundColor(.primaryText)
          .font(.body2)
          .lineLimit(1)
        HStack {
          Text(media.releaseDateYear)
            .font(.caption1)
            .foregroundColor(.secondaryText)
          Spacer()
          HStack(spacing: 2) {
            Image("star")
              .resizable()
              .frame(width: 13, height: 13)
              .foregroundColor(.mainOrange)
            Text(media.formatedVote)
              .font(.caption1)
              .foregroundColor(.secondaryText)
          }
        }
      }
    }
    .foregroundColor(.white)
    .frame(maxWidth: 152)
    .eraseToAnyView()
      //      .enableInjection()
  }
  
}



struct RedactedMovieCardView: View {
  
  var body: some View {
    VStack(alignment: .leading) {
      Image("spiderman")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 152, height: 204)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .redacted(reason: .placeholder)
      
      VStack(alignment: .leading, spacing: 4) {
        Text("               ")
          .foregroundColor(.primaryText)
          .font(.body2)
          .lineLimit(1)
        HStack {
          Text("2021")
            .font(.caption1)
            .foregroundColor(.secondaryText)
          Spacer()
          HStack(spacing: 2) {
            Image("star")
              .resizable()
              .frame(width: 13, height: 13)
              .foregroundColor(.mainOrange)
            Text("    ")
              .font(.caption1)
              .foregroundColor(.secondaryText)
          }
        }
      }
    }
    .frame(maxWidth: 152)
    .foregroundColor(.white)
    .redacted(reason: .placeholder)
    .shimmering()
    .eraseToAnyView()
  }
  
#if DEBUG
  @ObservedObject var iO = injectionObserver
#endif
}

struct MovieCard_Previews: PreviewProvider {
  static var previews: some View {
    MediaCardView(media: Movie(id: 1, title: "Spider man", posterPath: "", vote: 5.6, releaseDateString: Date().description, overview: ""))
      .preferredColorScheme(.dark)
  }
}
