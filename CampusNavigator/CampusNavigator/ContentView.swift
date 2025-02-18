//
//  ContentView.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-18.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        LoginView()
    }

}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
