//
//  AllEventsStaff.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-20.
//

import SwiftUI

struct AllEventsStaff: View {
    @ObservedObject var eventManager = EventManager()
    let imageHelper = ImageHelper()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: AddEvent()) {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.blue)
                            .padding()
                    }
                }
                
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(eventManager.getAllEvents(), id: \.id) { event in
                            VStack(alignment: .leading, spacing: 10) {
                                    EventCardStaff(event: event, image: imageHelper.loadImage(eventId: event.id))
                                        .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Upcoming Events")
        }
    }
}

struct EventCardStaff: View {
    let event: Event
    let image: UIImage?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Group {
                if let uiImage = image {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 200)
                        .overlay(
                            Text("No Image")
                                .foregroundColor(.gray)
                                .font(.headline)
                        )
                        .cornerRadius(10)
                }
            }
            .frame(maxWidth: .infinity)
            
            Text(event.title)
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.primary)
            
            HStack{
                Text(event.dateTime + " onwards")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                NavigationLink(destination: EditEvent(event: event)) {
                    Image(systemName: "pencil")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.blue)
                }
            }
            Text(event.location)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if event.allowVolunteers {
                Button(action: {}) {
                    NavigationLink{
                        VolunteerView(event: event)
                    } label: {
                        Text("View Volunteers")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .underline()
                    }
                }
            }
            
        }
    }
}

#Preview {
    AllEventsStaff()
}
