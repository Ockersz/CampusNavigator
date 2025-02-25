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
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                
            NotificationsView()
                .tabItem {
                    Image(systemName: "bell")
                    Text("Notifications")
                }
                
            RewardsView()
                .tabItem {
                    Image(systemName: "gift")
                    Text("Rewards")
                }
                
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct HomeView: View {
    var body: some View {
        NavigationView {
            Text("Home View")
                .navigationTitle("Home")
        }
    }
}

struct NotificationsView: View {
    var body: some View {
        NavigationView {
            Text("Notifications View")
                .navigationTitle("Notifications")
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

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Text("Settings View")
                .navigationTitle("Settings")
        }
    }
}

#Preview {
    NavigationBarView()
}
