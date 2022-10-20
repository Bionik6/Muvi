import SwiftUI

public enum Inter: String, CaseIterable {
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
    return .inter(.semiBold, size: 14)
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


public struct InterFont {
  public static func registerFonts() {
    Inter.allCases.forEach {
      registerFont(bundle: .module, fontName: $0.rawValue, fontExtension: "ttf")
    }
  }
  
  fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
          let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
          let font = CGFont(fontDataProvider) else {
      fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
    }
    
    var error: Unmanaged<CFError>?
    CTFontManagerRegisterGraphicsFont(font, &error)
  }
  
}


extension View {
  /// Attach this to any Xcode Preview's view to have custom fonts displayed
  /// Note: Not needed for the actual app
  public func loadCustomFonts() -> some View {
    InterFont.registerFonts()
    return self
  }
}
