import SwiftUI

@main
struct MuviApp: App {
  
  init() {
    AppRouter.registerRoutes()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
