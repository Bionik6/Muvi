import Foundation

struct Movie {
  let id: Int
  let title: String
  let posterPath: String
  let voteAverage: Double
    //  let releaseDate: Date
  let overview: String
  
  var actors: [Actor] = []
  var formatedVote: String { String(format: "%.1f", voteAverage) }
}


struct RemoteMovie: Decodable {
  let id: Int
  let title: String?
  let posterPath: String
  let voteAverage: Double
    //  let releaseDate: Date
  let overview: String
  let name: String?
  
  public init(
    id: Int,
    title: String?,
    posterPath: String,
    voteAverage: Double,
    //    releaseDate: Date,
    name: String?,
    overview: String
  ) {
    self.id = id
    self.title = title
    self.posterPath = posterPath
    self.voteAverage = voteAverage
      //    self.releaseDate = releaseDate
    self.overview = overview
    self.name = name
  }
  
  /* enum CodingKeys: String, CodingKey {
   case id, title, overview
   case posterPath = "post_path"
   case voteAverage = "vote_average"
   case releaseDate = "release_date"
   } */
  
  public var model: Movie {
    return Movie(
      id: id,
      title: title ?? name ?? "Unknow Movie",
      posterPath: posterPath,
      voteAverage: voteAverage,
      //      releaseDate: releaseDate,
      overview: overview
    )
  }
  
}

struct MoviesResponse: Decodable {
  let results: [RemoteMovie]
}
