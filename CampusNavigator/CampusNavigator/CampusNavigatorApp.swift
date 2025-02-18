//
//  CampusNavigatorApp.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-18.
//

import SwiftUI

@main
struct CampusNavigatorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
