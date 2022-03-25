import Foundation

struct RemoteActor: Decodable {
  let id: Int
  let order: Int
  let originalName: String
  let character: String
  let profilePath: String
  
  var model: Actor {
    Actor(
      id: id,
      order: order,
      realName: originalName,
      characterName: character,
      profileImagePath: profilePath
    )
  }
}
