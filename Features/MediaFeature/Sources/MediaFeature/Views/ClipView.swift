import SwiftUI

struct ClipView: View {
  
  let clip: Clip
  
  var body: some View {
    VStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .fill(Color(hex: "292929"))
        .frame(height: 92)
        .overlay {
          Image("youtube")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 80)
        }
      Text(clip.name)
        .font(.body2)
        .lineSpacing(4)
        .multilineTextAlignment(.leading)
    }
    
  }
}
