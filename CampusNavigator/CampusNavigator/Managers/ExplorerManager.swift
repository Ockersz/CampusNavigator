//
//  ExplorerManager.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-26.
//

import Foundation

struct ExplorerLocation: Codable, Identifiable {
    let id: Int
    var name: String
    var description: String
    var icon: String?
    var directions: [Guide]
}

struct Guide: Codable {
    var order: Int
    var location: String
    var guide: String
}

class ExplorerManager: ObservableObject {
    @Published var locations: [ExplorerLocation] = []
    private let imageHelper = ImageHelper()
    
    init() {
        loadLocations()
    }
    
    private func loadLocations() {
        guard let filePath = Bundle.main.url(forResource: "locationExp", withExtension: "json"),
              let data = try? Data(contentsOf: filePath) else {
            print("locationExp.json not found in the bundle")
            return
        }
        
        let decoder = JSONDecoder()
        if let loadedLocations = try? decoder.decode(
            [ExplorerLocation].self,
            from: data
        ) {
            DispatchQueue.main.async {
                self.locations = loadedLocations
            }
        } else {
            print("Failed to decode locations from JSON")
        }
    }
    
    func getAllLocations() -> [ExplorerLocation] {
        return locations
    }
    
    func getGuideLocation(locationId: Int) -> [Guide]? {
        return locations.first(where: { $0.id == locationId })?.directions
    }
}
