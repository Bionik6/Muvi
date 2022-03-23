import SwiftUI

struct MovieCard: View {
  
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
        Text(movie.title)
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
            Text(movie.formatedVote)
              .font(.caption1)
              .foregroundColor(.secondaryText)
          }
        }
      }
    }
    .frame(maxWidth: 152)
  }
}

struct MovieCard_Previews: PreviewProvider {
  static var previews: some View {
    MovieCard(movie: Movie(id: 1, title: "Spider man", posterPath: "", voteAverage: 5.6, overview: ""))
      .preferredColorScheme(.dark)
  }
}
