//
//  NavigationBarView.swift
//  CampusNavigator
//
//  Created by suresh 030 on 2025-02-18.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        TabView {
            StudentDashboardView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                
            CrowdLevels()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Crowd Levels")
                }
                
            CanteenView()
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Canteen")
                }
            
            RewardsView()
                .tabItem {
                    Image(systemName: "gift")
                    Text("Rewards")
                }
        }
    }
}

struct RewardsView: View {
    var body: some View {
        NavigationView {
            Text("Rewards View")
                .navigationTitle("Rewards")
        }
    }
}

#Preview {
    NavigationBarView()
}
