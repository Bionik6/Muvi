import Foundation

public struct Actor {
  public let id: Int
  public let order: Int
  public let realName: String
  public let characterName: String?
  public let profileImagePath: String?
  
  public var profileImageURL: URL {
    guard var url = URL(string: "https://image.tmdb.org/t/p/w200") else { fatalError("URL can't be constructed") }
    url.appendPathComponent(profileImagePath ?? "")
    return url
  }
  
  public init(
    id: Int,
    order: Int,
    realName: String,
    characterName: String?,
    profileImagePath: String?
  ) {
    self.id = id
    self.order = order
    self.realName = realName
    self.characterName = characterName
    self.profileImagePath = profileImagePath
  }
  
}
