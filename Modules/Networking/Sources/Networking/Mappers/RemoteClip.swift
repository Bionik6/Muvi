import Core 
import Foundation

struct RemoteClip: Decodable {
  let name: String
  let site: String
  let key: String
  let type: String
  let publishedAt: String
  
  var model: Clip {
    Clip(
      name: name,
      site: ClipSite(rawValue: site),
      key: key,
      type: ClipType(rawValue: type),
      publishedDateString: publishedAt
    )
  }
}
