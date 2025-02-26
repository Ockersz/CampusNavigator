//
//  VolunteerEvent.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-19.
//

import SwiftUI

struct VolunteerEvent: View {
    let event: Event
    let image: UIImage?
    
    @State private var name: String = ""
    @State private var batch: String = ""
    @State private var contact: String = ""
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var eventManager = EventManager()
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Batch", text: $batch)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Contact", text: $contact)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    addVolunteer()
                }) {
                    Text("Submit")
                        .foregroundColor(.black)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 44)
                .background(Color.yellow.opacity(0.7))
                .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("Sign Up As Volunteer")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Successfully Volunteered"),
                message: Text("Thank you for your support!"),
                dismissButton: .default(Text("OK")) {
                    self.presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    func addVolunteer() {
        
        let isSaved = eventManager.addVolunteer(
            eventId: event.id,
            name: name,
            batch: batch,
            contact: contact
        )
        
        if isSaved {
            showAlert = true
        }
    }
}
