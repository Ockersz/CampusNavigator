//
//  EventDetail.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-19.
//

import SwiftUI

struct EventDetail: View {
    let event: Event
    let image: UIImage?
    
    var body: some View {
        ScrollView {
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
                    .font(.title)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                
                Text(event.dateTime + " onwards")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .fontWeight(.light)
                
                Text(event.location)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .fontWeight(.light)
                
                Text(event.description)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .fontWeight(.light)
                
                if event.allowVolunteers {
                    NavigationLink(
                        destination: VolunteerEvent(event: event, image: image)
                    ) {
                        Text("Sign Up")
                           
                    }
                    .padding()
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .background(Color.yellow.opacity(0.7))
                    .cornerRadius(8)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(event.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
