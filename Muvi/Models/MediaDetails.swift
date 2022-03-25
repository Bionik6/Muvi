import Foundation

struct MediaDetails<T: Media> {
  let media: T
  let genres: [String]
}
