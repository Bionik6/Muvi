import Foundation

public struct MediaDetails {
  let media: any Media
  let genres: [String]
  
  public init(media: Media, genres: [String]) {
    self.media = media
    self.genres = genres
  }
}
