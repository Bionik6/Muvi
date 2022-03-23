import SwiftUI

public enum Inter: String {
  case regular = "Inter-Regular"
  case medium = "Inter-Medium"
  case semiBold = "Inter-SemiBold"
  case bold = "Inter-Bold"
}

extension Font {
  
  public static func inter(_ font: Inter, size: CGFloat) -> Font {
    return .custom(font.rawValue, size: size, relativeTo: .body)
  }
 
  public static var heading1: Font {
    return .inter(.bold, size: 26)
  }
  
  public static var heading2: Font {
    return .inter(.bold, size: 22)
  }
  
  public static var title1: Font {
    return .inter(.semiBold, size: 20)
  }
  
  public static var title2: Font {
    return .inter(.semiBold, size: 18)
  }
  
  public static var title3: Font {
    return .inter(.semiBold, size: 16)
  }
  
  public static var body1: Font {
    return .inter(.semiBold, size: 16)
  }
  
  public static var body2: Font {
    return .inter(.regular, size: 16)
  }
  
  public static var caption1: Font {
     return .inter(.regular, size: 14)
  }
  
  public static var caption2: Font {
    return .inter(.regular, size: 12)
  }
  
  public static var button: Font {
    return .inter(.medium, size: 16)
  }
}


public struct Heading1TextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.inter(.bold, size: 24))
      .modifier(CommontTextStyle())
  }
}

public struct Heading2TextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.inter(.bold, size: 24))
      .modifier(CommontTextStyle())
  }
}

public struct Title1TextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.inter(.semiBold, size: 18))
      .modifier(CommontTextStyle())
  }
}

public struct Title2TextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.inter(.semiBold, size: 16))
      .modifier(CommontTextStyle())
  }
}

public struct Title3TextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.inter(.semiBold, size: 14))
      .modifier(CommontTextStyle())
  }
}

public struct Body1TextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.inter(.regular, size: 16))
      .modifier(CommontTextStyle())
  }
}


public struct Body2TextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.inter(.regular, size: 14))
      .modifier(CommontTextStyle())
  }
}


public struct Caption1TextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.inter(.regular, size: 12))
      .modifier(CommontTextStyle())
  }
}


public struct Caption2TextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.inter(.regular, size: 10))
      .modifier(CommontTextStyle())
  }
}


public struct ButtonTextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
      .font(.inter(.medium, size: 14))
      .modifier(CommontTextStyle())
  }
}


private struct CommontTextStyle: ViewModifier {
  public func body(content: Content) -> some View {
    content
//      .frame(maxWidth: .infinity, alignment: .leading)
      .lineLimit(1)
      .multilineTextAlignment(.leading)
  }
}
