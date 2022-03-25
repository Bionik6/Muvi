import Foundation


struct RemoteSerieDetails: Decodable {
  struct Genre: Decodable {
    let id: Int
    let name: String
  }
  
  let id: Int
  let posterPath: String?
  let voteAverage: Double
  let releaseDate: String?
  let overview: String
  let name: String?
  let firstAirDate: String?
  let genres: [Genre]
  
  public init(
    id: Int,
    posterPath: String?,
    voteAverage: Double,
    releaseDate: String,
    name: String?,
    overview: String,
    firstAirDate: String?,
    genres: [Genre]
  ) {
    self.id = id
    self.posterPath = posterPath
    self.voteAverage = voteAverage
    self.releaseDate = releaseDate
    self.overview = overview
    self.name = name
    self.firstAirDate = firstAirDate
    self.genres = genres
  }
  
  public var model: MediaDetails {
    let serie = Serie(
      id: id,
      title: name ?? "Unknow Serie",
      posterPath: posterPath ?? "",
      vote: voteAverage,
      releaseDateString: releaseDate ?? firstAirDate ?? "Today",
      overview: overview
    )
    return MediaDetails(media: serie, genres: genres.compactMap { $0.name })
  }
  
}
