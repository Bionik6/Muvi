import SwiftUI
import CoreData


struct ContentView: View {
  
  var body: some View {
    TabView {
      VStack {
        ZStack {
          Color.background.edgesIgnoringSafeArea(.all)
          MoviesView()
        }
      }
      .tabItem({ TabLabel(imageName: "play.tv.fill", label: "Movies") })
      
      VStack {
        ZStack {
          Color.background.edgesIgnoringSafeArea(.all)
          SeriesView()
        }
      }
      .tabItem({ TabLabel(imageName: "rectangle.stack.badge.play.fill", label: "TV Shows") })
      
      VStack {
        Text("Watch List")
      }
      .tabItem({ TabLabel(imageName: "bookmark.fill", label: "Watch List") })
    }.preferredColorScheme(.dark)
      .eraseToAnyView()
  }

  #if DEBUG
  @ObservedObject var iO = injectionObserver
  #endif
  
}


struct TabLabel: View {
  let imageName: String
  let label: String
  
  var body: some View {
    HStack {
      Image(systemName: imageName)
      Text(label)
    }
      .eraseToAnyView()
  }

  #if DEBUG
  @ObservedObject var iO = injectionObserver
  #endif
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
