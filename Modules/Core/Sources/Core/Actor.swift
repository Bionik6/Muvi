import Foundation

public struct Actor {
  public let id: Int
  public let order: Int
  public let realName: String
  public let characterName: String?
  public let profileImagePath: String?
  
  var profileImageURL: URL {
    guard var url = URL(string: "https://image.tmdb.org/t/p/w200") else { fatalError("URL can't be constructed") }
    url.appendPathComponent(profileImagePath ?? "")
    return url
  }
}
