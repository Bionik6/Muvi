import Domain
import SwiftUI

public struct ComingSoonCard: View {
  private var media: any Media
  
  public init(media: any Media) {
    self.media = media
  }
  
  public var body: some View {
    VStack(alignment: .leading) {
      AsyncImage(url: media.posterURL) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 216, height: 122)
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
      } placeholder: {
        Image("thumbnail")
          .resizable()
          .frame(width: 216, height: 122)
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          .redacted(reason: .placeholder)
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text(media.title)
          .font(.body2)
        Text("Releases \(media.fullFormatedReleaseDate)")
          .font(.caption1)
          .foregroundColor(.secondaryText)
      }
    }
    .frame(maxWidth: 216)
    .foregroundColor(.white)
  }
}


public struct RedactedComingSoonMovieView: View {
  
  public init() { }
  
  public var body: some View {
    VStack(alignment: .leading) {
      Image("thumbnail")
        .resizable()
        .frame(width: 216, height: 122)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .redacted(reason: .placeholder)
      
      VStack(alignment: .leading, spacing: 4) {
        Text("        ")
          .font(.body2)
        Text("                   ")
          .font(.caption1)
          .foregroundColor(.secondaryText)
      }
    }
    .frame(maxWidth: 216)
    .redacted(reason: .placeholder)
  }
}

struct ComingSoonMovie_Previews: PreviewProvider {
  static var previews: some View {
    
    ComingSoonCard(media: Movie(id: 1, title: "Spider man", posterPath: "", vote: 5.6, releaseDateString: Date().description, overview: ""))
      .preferredColorScheme(.dark)
      .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/216.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/172.0/*@END_MENU_TOKEN@*/))
  }
}
