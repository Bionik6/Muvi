import Foundation

public struct MediaDetails {
  public let media: any Media
  public let genres: [String]
  
  public init(media: Media, genres: [String]) {
    self.media = media
    self.genres = genres
  }
}
