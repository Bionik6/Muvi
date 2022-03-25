import Foundation

public struct Serie: Media {
  public let id: Int
  public let title: String
  public let posterPath: String?
  public let vote: Double
  public let releaseDateString: String
  public let overview: String
}
