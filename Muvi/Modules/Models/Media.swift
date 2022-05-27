import Foundation

enum MediaType {
  case movie
  case serie
}

protocol Media {
  var id: Int { get }
  var title: String { get }
  var posterPath: String? { get }
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
    do {
      return try Date(releaseDateString, strategy: strategy)
    } catch {
      return Date()
    }
  }
  
  var posterURL: URL {
    guard var url = URL(string: "https://image.tmdb.org/t/p/w200") else { fatalError("URL can't be constructed") }
    url.appendPathComponent(posterPath ?? "")
    return url
  }
  
  var largerPosterURL: URL {
    guard var url = URL(string: "https://image.tmdb.org/t/p/w400") else { fatalError("URL can't be constructed") }
    url.appendPathComponent(posterPath ?? "")
    return url
  }
}


extension Sequence where Element: Media {
  func sequentially() -> [Movie] {
    self.lazy.filter { $0.posterPath != nil }.sorted { $0.releaseDate > $1.releaseDate } as! [Movie]
  }
  
  func sequentially() -> [Serie] {
    self.lazy.filter { $0.posterPath != nil }.sorted { $0.releaseDate > $1.releaseDate } as! [Serie]
  }
}
