//
//  quizApp.swift
//  Shared
//
//  Created by Diego Domínguez Herreros on 4/3/22.
//

import SwiftUI

@main
struct quizApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
