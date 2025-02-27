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
    @State private var isAuthenticated: Bool = false
    
    var body: some View {
        if isAuthenticated {
            MainTabView()
        } else {
            LoginView(isAuthenticated: $isAuthenticated)
        }
    }

}

struct MainTabView: View {
    @State private var selectedTab: Int = 0
    @State private var homeViewId = UUID()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                StudentDashboardView(selectedTab: $selectedTab)
                    .id(homeViewId)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)
            .onChange(of: selectedTab) {
                if selectedTab == 0 {
                    homeViewId = UUID()
                }
            }
            
            NavigationStack {
                CrowdLevels()
            }
            .tabItem {
                Label("Crowd", systemImage: "person.3.fill")
            }
            .tag(1)
            
            NavigationStack {
                CanteenView()
            }
            .tabItem {
                Label("Canteen", systemImage: "fork.knife")
            }
            .tag(2)
            
            NavigationStack {
                RedeemView()
            }
            .tabItem {
                Label("Redeem", systemImage: "gift.fill")
            }
            .tag(3)
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
