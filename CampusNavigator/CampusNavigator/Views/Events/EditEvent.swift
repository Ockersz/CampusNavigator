//
//  EditEvent.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-20.
//

import SwiftUI

struct EditEvent: View {
    let event: Event
    
    @ObservedObject var eventManager = EventManager()
    
    @State private var title: String
    @State private var location: String
    @State private var dateTime: Date
    @State private var description: String
    @State private var allowVolunteers: Bool
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    
    init(event: Event) {
        self.event = event
        let dateHelper = DateHelper()
        
        let eventDate = dateHelper.stringToDate(dateString: event.dateTime) ?? Date()
        
        _title = State(initialValue: event.title)
        _location = State(initialValue: event.location)
        _dateTime = State(initialValue: eventDate)
        _description = State(initialValue: event.description)
        _allowVolunteers = State(initialValue: event.allowVolunteers)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Button(action: { isImagePickerPresented.toggle() }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 2, dash: [5]))
                            .frame(height: 200)
                        
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else if let eventImage = ImageHelper().loadImage(eventId: event.id) {
                            Image(uiImage: eventImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } else {
                            VStack {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.gray)
                                
                                Text("Tap to upload an image")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                .padding()
                
                TextField("Title", text: $title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Location", text: $location)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                DatePicker("Date and Time", selection: $dateTime)
                    .padding()
                
                TextField("Description", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Toggle("Allow Volunteers", isOn: $allowVolunteers)
                    .padding()
                
                Button(action: saveEvent) {
                    Text("Edit Event")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow.opacity(0.7))
                        .foregroundColor(.black)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Edit Event")
   
        }
    }
    
    private func saveEvent() {
        
       let isEdited =  eventManager
            .editEvent(
                id: event.id,
                title: title,
                location: location,
                date: dateTime,
                description: description,
                allowVolunteers: allowVolunteers,
                image: selectedImage
            )
        
        print(isEdited)
    }
}
