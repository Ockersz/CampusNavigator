//
//  CampusSurfer.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-26.
//

import SwiftUI

struct CampusSurfer: View {
    @StateObject var explorerManager = ExplorerManager()
    @State var showHTP: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { showHTP = true }) {
                            Image("howToPlay")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 8) {
                        ForEach(explorerManager.getAllLocations(), id: \.id) { location in
                            if location.icon != "completedImg" {
                                NavigationLink(destination: Navigator(location: location)) {
                                    ExploreCard(location: location)
                                }
                            } else {
                                ExploreCard(location: location)
                                    .opacity(0.5) 
                            }
                        }
                    }
                    
                }
                .padding()
            }
            .navigationTitle("Campus Surfer")
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: $showHTP) {
                Alert(
                    title: Text("How to Play").underline(true, color: .primary),
                    message: Text("\nClick on any of the challenges and scan to start the game. Once completed scan the destination to complete the challenge and earn credits. \n\n Info: Credits can be redeemed in the redeem section to receive rewards such as canteen products and mobile reloads. "),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct ExploreCard: View {
    var location: ExplorerLocation
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if let icon = location.icon {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .cornerRadius(10)
            }
            
            Text(location.name)
                .font(.subheadline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
            
            Text(location.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    CampusSurfer()
}
