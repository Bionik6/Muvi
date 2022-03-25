import Foundation

public struct Movie: Media {
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
  
  public var formatedVote: String { String(format: "%.1f", vote) }
  
  public var releaseDateYear: String {
    releaseDate.formatted(.dateTime.year())
  }
  
  public var fullFormatedReleaseDate: String {
    releaseDate.formatted(date: .long, time: .omitted)
  }
  
  public var releaseDate: Date {
    let strategy = Date.ISO8601FormatStyle().year().month().day().dateSeparator(.dash)
    return try! Date(releaseDateString, strategy: strategy)
  }
}
