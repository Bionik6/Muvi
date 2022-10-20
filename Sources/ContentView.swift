import SwiftUI
import MovieFeature
import SerieFeature

struct ContentView: View {
  @Environment(\.router) var router
  
  var body: some View {
    TabView {
      VStack {
        ZStack {
          Color.background.edgesIgnoringSafeArea(.all)
          router.resolve(path: "/movies")
          // MoviesView()
        }
      }
      .tabItem({ TabLabel(imageName: "play.tv.fill", label: "Movies") })
      
      VStack {
        ZStack {
          Color.background.edgesIgnoringSafeArea(.all)
          router.resolve(path: "/tv-shows")
          // SeriesView()
        }
      }
      .tabItem({ TabLabel(imageName: "rectangle.stack.badge.play.fill", label: "TV Shows") })
      
      VStack {
        Text("Watch List")
      }
      .tabItem({ TabLabel(imageName: "bookmark.fill", label: "Watch List") })
    }.preferredColorScheme(.dark)
  }
  
}


struct TabLabel: View {
  let imageName: String
  let label: String
  
  var body: some View {
    HStack {
      Image(systemName: imageName)
      Text(label)
    }
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
