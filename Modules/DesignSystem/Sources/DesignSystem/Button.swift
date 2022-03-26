import SwiftUI


public struct PrimaryButton: View {
  public private(set) var title: String
  public private(set) var systemImage: String
  public private(set) var action: () -> ()
  
  public init(title: String, systemImage: String, action: @escaping () -> ()) {
    self.title = title
    self.systemImage = systemImage
    self.action = action
  }
  
  public var body: some View {
    Button(action: action) {
      Label(title, systemImage: systemImage)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .foregroundColor(.white)
        .font(.button)
    }
    .background(content: {
      RoundedRectangle(cornerRadius: 4, style: .continuous).fill(Color.accentColor)
    })
    .frame(maxWidth: .infinity)
  }
  
}


struct OutlineButton: View {
  let title: String
  let systemImage: String
  let action: () -> ()
  
  var body: some View {
    Button(action: action) {
      Label(title, systemImage: systemImage)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .foregroundColor(.accentColor)
        .font(.button)
    }
    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.accentColor, lineWidth: 2))
    .frame(maxWidth: .infinity)
  }
  
}
