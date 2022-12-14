import SwiftUI

enum CardType {
  case landscape
  case portrait
}

struct MediaSection<Content: View>: View {
  private let media: [Media]
  private let title: String
  private let redactedViewsNumber: Int
  private let type: CardType
  @ViewBuilder private let content: () -> Content
  
  public init(
    media: [Media],
    title: String,
    redactedViewsNumber: Int,
    type: CardType,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.media = media
    self.title = title
    self.redactedViewsNumber = redactedViewsNumber
    self.type = type
    self.content = content
  }
  
  var body: some View {
    Section(content: {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 16) {
          if media.count == 0 {
            ForEach(0..<redactedViewsNumber, id: \.self) { idx in
              if type == .landscape { RedactedComingSoonMovieView() } else { RedactedMovieCardView() }
            }
          } else {
            content()
          }
        }
        .padding(.leading)
        .padding(.bottom, 24)
      }
    }, header: {
      HeaderView(title: title)
    })
      .eraseToAnyView()
  }

  #if DEBUG
  @ObservedObject var iO = injectionObserver
  #endif
}



struct HeaderView: View {
  var title: String
  
  var body: some View {
    HStack {
      Text(title)
        .font(.heading2)
      Spacer()
      Button {
      } label: {
        HStack(spacing: 6) {
          Text("See All").foregroundColor(.accentColor).font(.button)
          Image(systemName: "chevron.right").foregroundColor(.accentColor).font(.caption)
        }
        
      }
    }.padding(.horizontal)
      .eraseToAnyView()
  }

  #if DEBUG
  @ObservedObject var iO = injectionObserver
  #endif
}

