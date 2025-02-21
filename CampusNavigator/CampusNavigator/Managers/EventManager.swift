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

struct Event: Codable {
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
        return URL(fileURLWithPath: "/Users/shaheinockersz/dev/CampusNavigator/CampusNavigator/CampusNavigator/Data/event.json")
    }
    
    private func loadEvents() {
        let filePath = getFilePath()
        
        guard FileManager.default.fileExists(atPath: filePath.path),
              let data = try? Data(contentsOf: filePath) else {
            return
        }
        
        let decoder = JSONDecoder()
        if let loadedEvents = try? decoder.decode([Event].self, from: data) {
            DispatchQueue.main.async {
                self.events = loadedEvents
            }
        } else {
            print("Failed to decode events from data")
        }
    }
    
    private func saveEvents() {
        let filePath = getFilePath()
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(events) {
            try? data.write(to: filePath)
        }
    }
    
    func createEvent(name: String, description: String, date: Date, location: String, image: UIImage?, allowVolunteers: Bool) -> Event {
        let maxId = events.max(by: { $0.id < $1.id })?.id ?? 0
        let dateHelper = DateHelper()
        let dateString = dateHelper.dateToString(date: date, format: "dd/MM/yyyy HH:mm a")
        
        var imagePath: String? = nil
        
        if let eventImage = image {
            let isSaved = imageHelper.saveImage(image: eventImage, eventId: maxId + 1)
            if isSaved {
                imagePath = "\(maxId + 1).jpg"
            }
        }
        
        let newEvent = Event(
            id: maxId + 1,
            title: name,
            location: location,
            dateTime: dateString,
            description: description,
            imagePath: imagePath,
            allowVolunteers: allowVolunteers,
            volunteers: []
        )
        
        self.events.append(newEvent)
        self.saveEvents()
        
        return newEvent
    }
    
    func editEvent(id: Int, title: String, location: String, date: Date, description: String, allowVolunteers: Bool, image: UIImage?) -> Bool {
        
        let dateHelper = DateHelper()
        let dateString = dateHelper.dateToString(date: date, format: "dd/MM/yyyy HH:mm a")
     
        guard let index = self.events.firstIndex(where: { $0.id == id }) else {
            print("Event not found")
            return false
        }
        
        var imagePath: String? = nil
        
        if let eventImage = image {
            let isSaved = imageHelper.saveImage(image: eventImage, eventId: id)
            if isSaved {
                imagePath = "\(id).jpg"
            }
        }
        
        self.events[index].title = title
        self.events[index].location = location
        self.events[index].dateTime = dateString
        self.events[index].imagePath = imagePath
        self.events[index].description = description
        self.events[index].allowVolunteers = allowVolunteers
        
        self.saveEvents()
        
        return true;
        
    }
    
    func addVolunteer(id: Int, name: String, batch: String, contact: String) -> Bool {
        
        print(id)
        guard let index = self.events.firstIndex(where: { $0.id == id }) else {
            print("Event not found")
            return false
        }
        
        var maxVolunteerId = 0
        
        if self.events[index].volunteers.count > 0 {
            maxVolunteerId = self.events[index].volunteers.max(by: { $0.id < $1.id })!.id
        }
        
        let newVolunteer = Volunteer(
            id: maxVolunteerId + 1,
            name: name,
            batch: batch,
            contact: contact
        )
        
        self.events[index].volunteers.append(newVolunteer)
        
        self.saveEvents()
        
        return true
    }
    
    func getAllVolunteers(id: Int) -> [Volunteer]{
        guard let index = self.events.firstIndex(where: { $0.id == id }) else {
            print("Event not found")
            return []
        }
        print(index)
        
        
        
        return self.events[index].volunteers
    }

    
    func getAllEvents() -> [Event] {
        return events.map { event in
            var modifiedEvent = event
            if event.imagePath != nil {
                modifiedEvent.imagePath = loadImagePath(eventId: event.id)
            }
            return modifiedEvent
        }
    }
    
    func getEventById(id: Int) -> Event? {
        guard let event = events.first(where: { $0.id == id }) else { return nil }
        
        var modifiedEvent = event
        if event.imagePath != nil {
            modifiedEvent.imagePath = loadImagePath(eventId: id)
        }
        return modifiedEvent
    }
    
    private func loadImagePath(eventId: Int) -> String? {
        let image = imageHelper.loadImage(eventId: eventId)
        return image != nil ? "\(eventId).jpg" : nil
    }
}
