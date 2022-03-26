import Foundation

public enum MediaType {
  case movie
  case serie
}

public protocol Media {
  var id: Int { get }
  var title: String { get }
  var posterPath: String? { get }
  var vote: Double { get }
  var releaseDateString: String { get }
  var overview: String { get }
}


extension Media {
  public var formatedVote: String { String(format: "%.1f", vote) }
  public var releaseDateYear: String { releaseDate.formatted(.dateTime.year()) }
  public var fullFormatedReleaseDate: String { releaseDate.formatted(date: .long, time: .omitted) }
  
  public var releaseDate: Date {
    let strategy = Date.ISO8601FormatStyle().year().month().day().dateSeparator(.dash)
    return try! Date(releaseDateString, strategy: strategy)
  }
  
  public var posterURL: URL {
    guard var url = URL(string: "https://image.tmdb.org/t/p/w200") else { fatalError("URL can't be constructed") }
    url.appendPathComponent(posterPath ?? "")
    return url
  }
  
  public var largerPosterURL: URL {
    guard var url = URL(string: "https://image.tmdb.org/t/p/w400") else { fatalError("URL can't be constructed") }
    url.appendPathComponent(posterPath ?? "")
    return url
  }
}


extension Sequence where Element: Media {
  public func sequentially() -> [Movie] {
    self.lazy.filter { $0.posterPath != nil }.sorted { $0.releaseDate > $1.releaseDate } as! [Movie]
  }
  
  public func sequentially() -> [Serie] {
    self.lazy.filter { $0.posterPath != nil }.sorted { $0.releaseDate > $1.releaseDate } as! [Serie]
  }
}
