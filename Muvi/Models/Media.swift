import Foundation

enum MediaType {
  case movie(Movie)
  case serie(Serie)
}

struct Media {
  private let type: MediaType
  
  init(type: MediaType) {
    self.type = type
  }
  
  
  var title: String {
    ""
  }
  
  var posterPath: String {
    ""
  }
  
  var vote: Double {
    0.0
  }
  
  
}
