import Foundation


struct RemoteSerie: Decodable {
  let id: Int
  let posterPath: String?
  let voteAverage: Double
  let releaseDate: String?
  let overview: String
  let name: String?
  let firstAirDate: String?
  
  public init(
    id: Int,
    posterPath: String?,
    voteAverage: Double,
    releaseDate: String,
    name: String?,
    overview: String,
    firstAirDate: String?
  ) {
    self.id = id
    self.posterPath = posterPath
    self.voteAverage = voteAverage
    self.releaseDate = releaseDate
    self.overview = overview
    self.name = name
    self.firstAirDate = firstAirDate
  }
  
  public var model: Serie {
    return Serie(
      id: id,
      title: name ?? "Unknow Serie",
      posterPath: posterPath,
      vote: voteAverage,
      releaseDateString: releaseDate ?? firstAirDate ?? "Today",
      overview: overview
    )
  }
  
}
