import Domain
import Foundation

public struct RemoteClip: Decodable {
  let name: String
  let site: String
  let key: String
  let type: String
  let publishedAt: String
  
  public var model: Clip {
    Clip(
      name: name,
      site: ClipSite(rawValue: site),
      key: key,
      type: ClipType(rawValue: type),
      publishedDateString: publishedAt
    )
  }
}
