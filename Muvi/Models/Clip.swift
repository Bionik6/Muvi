import Foundation

enum ClipType: String {
  case bloopers = "Bloopers"
  case trailer = "Trailer"
  case teaser = "Teaser"
  case bts = "Behind the Scenes"
  case clip = "Clip"
  case opening = "Opening Credits"
}

enum ClipSite: String {
  case youtube = "YouTube"
}


struct Clip {
  let name: String
  let site: ClipSite?
  let key: String
  let type: ClipType?
  let publishedDateString: String
}
