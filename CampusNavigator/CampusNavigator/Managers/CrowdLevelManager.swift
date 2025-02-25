//
//  CrowdLevelManager.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-21.
//

import Foundation

struct Location : Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var icon: String
}

class CrowdLevelManager : ObservableObject{
    
    
    @Published private var locations: [Location] = []
    
    
    init(){
        loadLocations()
    }
    
    private func loadLocations() {
        guard let filePath = Bundle.main.url(forResource: "locationMas", withExtension: "json"),
              let data = try? Data(contentsOf: filePath) else {
            print("locationMas.json not found in the bundle")
            return
        }
        
        let decoder = JSONDecoder()
        if let loadedLocations = try? decoder.decode([Location].self, from: data) {
            DispatchQueue.main.async {
                self.locations = loadedLocations
            }
            print("Loaded \(loadedLocations.count) locations")
        } else {
            print("Failed to decode locations from JSON")
        }
    }

    func getAllLocations() -> [Location] {
        return locations;
    }
    
}
