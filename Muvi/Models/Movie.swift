import Foundation

struct Movie: Media {
  let id: Int
  let title: String
  let posterPath: String?
  let vote: Double
  let releaseDateString: String
  let overview: String
  
  var formatedVote: String { String(format: "%.1f", vote) }
  
  var releaseDateYear: String {
    releaseDate.formatted(.dateTime.year())
  }
  
  var fullFormatedReleaseDate: String {
    releaseDate.formatted(date: .long, time: .omitted)
  }
  
  var releaseDate: Date {
    let strategy = Date.ISO8601FormatStyle().year().month().day().dateSeparator(.dash)
    return try! Date(releaseDateString, strategy: strategy)
  }
}
