//
//  EventManager.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-18.
//

import Foundation
import UIKit

struct Volunteer: Codable, Identifiable {
    let id: Int
    var name: String
    var batch: String
    var contact: String
}

struct Event: Codable, Identifiable {
    var id: Int
    var title: String
    var location: String
    var dateTime: String
    var description: String
    var imagePath: String?
    var allowVolunteers: Bool
    var volunteers: [Volunteer]
}

class EventManager: ObservableObject {
    @Published private var events: [Event] = []
    private let imageHelper = ImageHelper()
    
    init() {
        loadEvents()
    }
    
    private func getFilePath() -> URL {
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent("events.json")
    }
    
    private func loadEvents() {
        let filePath = getFilePath()
        
        guard FileManager.default.fileExists(atPath: filePath.path),
              let data = try? Data(contentsOf: filePath) else {
            print("events.json not found, initializing empty event list")
            self.events = []
            return
        }
        
        let decoder = JSONDecoder()
        if let loadedEvents = try? decoder.decode([Event].self, from: data) {
            DispatchQueue.main.async {
                self.events = loadedEvents
            }
        } else {
            print("Failed to decode events from JSON")
        }
    }
    
    private func saveEvents() {
        let filePath = getFilePath()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(events)
            try data.write(to: filePath, options: .atomic)
            print("Successfully saved events to file")
        } catch {
            print("Failed to save events: \(error)")
        }
    }
    
    func getAllEvents() -> [Event] {
        return events
    }
    
    func getEventById(id: Int) -> Event? {
        return events.first(where: { $0.id == id })
    }
    
    func createEvent(title: String, description: String, date: Date, location: String, image: UIImage?, allowVolunteers: Bool) -> Event {
        let maxId = events.map({ $0.id }).max() ?? 0
        let dateString = DateHelper().dateToString(date: date, format: "dd/MM/yyyy HH:mm a")
        
        var imagePath: String? = nil
        if let eventImage = image, imageHelper.saveImage(image: eventImage, eventId: maxId + 1) {
            imagePath = "\(maxId + 1).jpg"
        }
        
        let newEvent = Event(
            id: maxId + 1,
            title: title,
            location: location,
            dateTime: dateString,
            description: description,
            imagePath: imagePath,
            allowVolunteers: allowVolunteers,
            volunteers: []
        )
        
        events.append(newEvent)
        saveEvents()
        return newEvent
    }
    
    func editEvent(id: Int, title: String, location: String, date: Date, description: String, allowVolunteers: Bool, image: UIImage?) -> Bool {
        guard let index = events.firstIndex(where: { $0.id == id }) else {
            print("Event not found")
            return false
        }
        
        let dateString = DateHelper().dateToString(date: date, format: "dd/MM/yyyy HH:mm a")
        var imagePath: String? = nil
        
        if let eventImage = image, imageHelper.saveImage(image: eventImage, eventId: id) {
            imagePath = "\(id).jpg"
        }
        
        events[index].title = title
        events[index].location = location
        events[index].dateTime = dateString
        events[index].description = description
        events[index].allowVolunteers = allowVolunteers
        events[index].imagePath = imagePath
        
        saveEvents()
        return true
    }
    
    func addVolunteer(eventId: Int, name: String, batch: String, contact: String) -> Bool {
        guard let index = events.firstIndex(where: { $0.id == eventId }) else {
            print("Event not found")
            return false
        }
        
        let maxVolunteerId = events[index].volunteers.map({ $0.id }).max() ?? 0
        let newVolunteer = Volunteer(id: maxVolunteerId + 1, name: name, batch: batch, contact: contact)
        
        events[index].volunteers.append(newVolunteer)
        saveEvents()
        return true
    }
    
    func getAllVolunteers(eventId: Int) -> [Volunteer] {
        return events.first(where: { $0.id == eventId })?.volunteers ?? []
    }
}
