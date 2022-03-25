import SwiftUI

struct ComingSoonCard: View {
 
  private var movie: Movie
  
  init(movie: Movie) {
    self.movie = movie
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200/\(movie.posterPath)")) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 216, height: 122)
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          .overlay {
            ZStack {
              Color.black.opacity(0.3)
              VStack {
                Image(systemName: "play.circle")
                  .resizable()
                  .frame(width: 26, height: 26)
                Text("Trailer")
                  .font(.caption1)
              }
            }
          }
      } placeholder: {
        Image("thumbnail")
          .resizable()
          .frame(width: 216, height: 122)
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          .redacted(reason: .placeholder)
      }
      
      VStack(alignment: .leading, spacing: 4) {
        Text(movie.title)
          .font(.body2)
        Text("Releases \(movie.fullFormatedReleaseDate)")
          .font(.caption1)
          .foregroundColor(.secondaryText)
      }
    }.frame(maxWidth: 216)
  }
}


struct RedactedComingSoonMovieView: View {
  var body: some View {
    VStack(alignment: .leading) {
      Image("thumbnail")
        .resizable()
        .frame(width: 216, height: 122)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        .redacted(reason: .placeholder)
      
      VStack(alignment: .leading, spacing: 4) {
        Text("        ")
          .font(.body2)
        Text("Releases February 11, 2022")
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
    
    ComingSoonCard(movie: Movie(id: 1, title: "Spider man", posterPath: "", vote: 5.6, releaseDateString: Date().description, overview: ""))
      .preferredColorScheme(.dark)
      .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/216.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/172.0/*@END_MENU_TOKEN@*/))
  }
}
