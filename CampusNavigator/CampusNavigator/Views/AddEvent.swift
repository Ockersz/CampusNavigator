//
//  AddEvent.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-18.
//

import SwiftUI

struct AddEvent: View {
    
    @ObservedObject var eventManager = EventManager()
    
    
    @State private var title: String = ""
    @State private var location: String = ""
    @State private var dateTime: Date = Date()
    @State private var description: String = ""
    @State private var allowVolunteers: Bool = false
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        VStack {
            Button(action: {
                isImagePickerPresented.toggle()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .frame(height: 200)
                        .padding()
                    
                    if let image = selectedImage {
                        Image(uiImage: image)
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
            
            
            Button(action: {
                addEvent()
            }) {
                Text("Add Event")
                    .foregroundColor(.black)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 44)
            .background(Color.yellow.opacity(0.7))
            .cornerRadius(8)
            
        }
        .navigationTitle("Add Event")
        .padding()
        
    }
    
    func addEvent() {
        print("Add Event")
        let newEvent = eventManager.createEvent(
            title: title,
            description: description,
            date: dateTime,
            location: location,
            image: selectedImage,
            allowVolunteers: allowVolunteers
        )
        
        
        print(newEvent)
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    AddEvent()
}
