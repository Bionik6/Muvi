import Foundation

enum MediaType {
  case movie(Movie)
  case serie(Serie)
}


protocol Media {
  var id: Int { get }
  var title: String { get }
  var posterPath: String { get }
  var vote: Double { get }
  var releaseDateString: String { get }
  var overview: String { get }
}


extension Media {
  var formatedVote: String { String(format: "%.1f", vote) }
  var releaseDateYear: String { releaseDate.formatted(.dateTime.year()) }
  var fullFormatedReleaseDate: String { releaseDate.formatted(date: .long, time: .omitted) }
  
  var releaseDate: Date {
    let strategy = Date.ISO8601FormatStyle().year().month().day().dateSeparator(.dash)
    return try! Date(releaseDateString, strategy: strategy)
  }
  
  var posterURL: URL {
    guard var url = URL(string: "https://image.tmdb.org/t/p/w200") else { fatalError("URL can't be constructed") }
    url.appendPathComponent(posterPath)
    return url
  }
}
