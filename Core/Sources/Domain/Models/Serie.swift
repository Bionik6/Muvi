import Foundation

public struct Serie: Media, Hashable {
  public let id: Int
  public let title: String
  public let posterPath: String?
  public let vote: Double
  public let releaseDateString: String
  public let overview: String
  
  public init(
    id: Int,
    title: String,
    posterPath: String?,
    vote: Double,
    releaseDateString: String,
    overview: String
  ) {
    self.id = id
    self.title = title
    self.posterPath = posterPath
    self.vote = vote
    self.releaseDateString = releaseDateString
    self.overview = overview
  }
}
