import Foundation

struct Actor {
  let id: Int
  let order: Int
  let realName: String
  let characterName: String?
  let profileImagePath: String?
  
  var profileImageURL: URL {
    guard var url = URL(string: "https://image.tmdb.org/t/p/w200") else { fatalError("URL can't be constructed") }
    url.appendPathComponent(profileImagePath ?? "")
    return url
  }
}
