import SwiftUI

struct ActorView: View {
  
  let actor: Actor
  
  var body: some View {
    VStack {
      AsyncImage(url: actor.profileImageURL) { image in
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 100, height: 100)
          .clipShape(Circle())
      } placeholder: {
        Circle()
          .fill(Color.gray)
          .frame(width: 100, height: 100)
      }.frame(width: 100, height: 100)
      
      VStack(spacing: 6) {
        Text(actor.realName)
          .font(.title3)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
        Text(actor.characterName != nil ?  actor.characterName!.isEmpty ? "" : "as \(actor.characterName!)" : "")
          .font(.caption1)
          .foregroundColor(.secondaryText)
          .multilineTextAlignment(.center)
      }
    }
      .eraseToAnyView()
  }

  #if DEBUG
  @ObservedObject var iO = injectionObserver
  #endif
}
