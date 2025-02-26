//
//  NavigationGuide.swift
//  CampusNavigator
//
//  Created by Siluni 025 on 2025-02-26.
//

import SwiftUI

struct NavigationGuide: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Programme Office")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Reach Elevator")
                            .font(.system(size: 17, weight: .semibold))
                        Text("Head forward")
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image("Forward")
                        .imageScale(.large)
                        .padding()
                }
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Reach 4th Floor")
                            .font(.system(size: 17, weight: .semibold))
                        Text("Use the elevator")
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image("Forward")
                        .imageScale(.large)
                        .padding()
                }
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("You are at the Destination!")
                            .font(.system(size: 17, weight: .semibold))
                        Text("Programme Office (Computing)")
                            .foregroundColor(Color.secondarys)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image("Checked")
                        .imageScale(.large)
                        .padding()
                }
            }
            .padding(20)
        }
    }
}

#Preview {
    NavigationGuide()
}
