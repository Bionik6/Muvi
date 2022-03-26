//
//  MuviApp.swift
//  Muvi
//
//  Created by Ibrahima Ciss on 23/03/2022.
//

import SwiftUI

@main
struct MuviApp: App {
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
