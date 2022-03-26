import Core
import Foundation


struct RemoteMovie: Decodable {
  let id: Int
  let title: String?
  let posterPath: String?
  let voteAverage: Double
  let releaseDate: String?
  let overview: String?
  let name: String?
  let firstAirDate: String?
  
  public init(
    id: Int,
    title: String?,
    posterPath: String?,
    voteAverage: Double,
    releaseDate: String,
    name: String?,
    overview: String?,
    firstAirDate: String?
  ) {
    self.id = id
    self.title = title
    self.posterPath = posterPath
    self.voteAverage = voteAverage
    self.releaseDate = releaseDate
    self.overview = overview
    self.name = name
    self.firstAirDate = firstAirDate
  }
  
  public var model: Movie {
    return Movie(
      id: id,
      title: title ?? name ?? "Unknow Movie",
      posterPath: posterPath,
      vote: voteAverage,
      releaseDateString: releaseDate ?? firstAirDate ?? "Today",
      overview: overview ?? ""
    )
  }
  
}
