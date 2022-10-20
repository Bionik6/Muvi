import SwiftUI
import DesignSystem

@main
struct MuviApp: App {
  
  init() {
    AppRouter.registerRoutes()
    InterFont.registerFonts()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
