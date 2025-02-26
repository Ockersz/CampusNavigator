//
//  VolunteerView.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-20.
//

import SwiftUI

struct VolunteerView: View {
    let event: Event
    
    @ObservedObject var eventManager = EventManager()
    
    var body: some View {
        VStack {
            if eventManager.getAllVolunteers(eventId: event.id).isEmpty {
                Text("No volunteers found.")
            } else {
                List(
                    eventManager.getAllVolunteers(eventId: event.id)
                ) { volunteer in
                    VolunteerCard(volunteer: volunteer)
                }
            }
        }
        .navigationTitle("Volunteers")
    }
}

struct VolunteerCard: View {
    let volunteer: Volunteer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(volunteer.name)
                .font(.headline)
                .fontWeight(.medium)
            Text("Batch: \(volunteer.batch)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("📞 \(volunteer.contact)")
                .font(.subheadline)
                .foregroundColor(.blue)
        }
        .padding()
    }
}

