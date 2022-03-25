  //
  //  ClipView.swift
  //  Muvi
  //
  //  Created by Ibrahima Ciss on 25/03/2022.
  //

import SwiftUI

struct ClipView: View {
  
  let clip: Clip
  
  var body: some View {
    VStack(alignment: .leading) {
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .frame(height: 92)
      Text(clip.name)
        .font(.body2)
        .lineSpacing(4)
    }
    
  }
}

//struct ClipView_Previews: PreviewProvider {
//  static var previews: some View {
//    ClipView()
//  }
//}
