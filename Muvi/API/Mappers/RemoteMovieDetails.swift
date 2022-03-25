import Foundation


struct RemoteMovieDetails: Decodable {
  struct Genre: Decodable {
    let id: Int
    let name: String
  }
  
  let id: Int
  let title: String?
  let posterPath: String
  let voteAverage: Double
  let releaseDate: String?
  let overview: String
  let name: String?
  let genres: [Genre]
  
  public init(
    id: Int,
    title: String?,
    posterPath: String,
    voteAverage: Double,
    releaseDate: String,
    name: String?,
    overview: String,
    genres: [Genre]
  ) {
    self.id = id
    self.title = title
    self.posterPath = posterPath
    self.voteAverage = voteAverage
    self.releaseDate = releaseDate
    self.overview = overview
    self.name = name
    self.genres = genres
  }
  
  public var model: MovieDetails {
    let movie = Movie(
      id: id,
      title: title ?? name ?? "Unknow Movie",
      posterPath: posterPath,
      vote: voteAverage,
      releaseDateString: releaseDate ?? "Today",
      overview: overview
    )
    return MovieDetails(movie: movie, genres: genres.compactMap { $0.name })
  }
  
}
