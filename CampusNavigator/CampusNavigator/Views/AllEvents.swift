//
//  AllEvents.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-19.
//
import SwiftUI

struct AllEvents: View {
    @ObservedObject var eventManager = EventManager()
    let imageHelper = ImageHelper()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(eventManager.getAllEvents(), id: \.id) { event in
                        NavigationLink(destination: EventDetail(event: event, image: imageHelper.loadImage(eventId: event.id))) {
                            EventCard(event: event, image: imageHelper.loadImage(eventId: event.id))
                                .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Campus Events")
        }
    }
}

struct EventCard: View {
    let event: Event
    let image: UIImage?
    let dateHelper = DateHelper()
    
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
            
            Text(event.title )
                .font(.headline)
                .lineLimit(1)
                .foregroundColor(.primary)
            
            Text(event.dateTime + " onwards")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(event.location)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

#Preview {
    AllEvents()
}
