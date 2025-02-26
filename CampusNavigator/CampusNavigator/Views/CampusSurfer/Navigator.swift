//
//  Navigator.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-26.
//

import SwiftUI

struct Navigator: View {
    
    var location: ExplorerLocation
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(location.directions, id: \.order) { guide in
                    VStack(alignment: .leading) {
                        Text("Step \(guide.order): \(guide.location)")
                            .font(.headline)
                            .padding(.bottom, 2)
                        Text(guide.guide)
                            .font(.body)
                            .padding(.bottom, 10)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                }
                
                NavigationLink(destination: QRScannerView()) {
                    Text("Scan To Complete")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.primary)
                        .background(Color("Accents"))
                        .cornerRadius(10)
                        .padding(.top, 20)
                }
            }
            .padding()
        }
        .navigationTitle(location.name)
    }
}

#Preview {
    Navigator(
        location: ExplorerLocation(
            id: 1,
            name: "Canteen",
            description: "Where you can have your meals",
            icon: "canteenImg",
            directions: [
                Guide(order: 1, location: "Entrance", guide: "Head to the entrance to start"),
                Guide(order: 2, location: "Canteen", guide: "You have reached the Canteen")
            ]
        )
    )
}
