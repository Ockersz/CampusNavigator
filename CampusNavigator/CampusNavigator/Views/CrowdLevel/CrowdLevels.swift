//
//  CrowdLevels.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-21.
//

import SwiftUI

struct CrowdLevels: View {
    
    @StateObject var crowdLevelManager = CrowdLevelManager()
    
    var body: some View {
            ScrollView {
                VStack{
                    ForEach(crowdLevelManager.getAllLocations(), id: \.id) { location in
                        LocationCard(location: location)
                    }
                }
                .padding()
            }
            .navigationTitle("Crowd Levels")
            .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    CrowdLevels()
}
