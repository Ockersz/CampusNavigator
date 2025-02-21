//
//  StudentDashboard.swift
//  CampusNavigator
//
//  Created by Siluni 025 on 2025-02-21.
//

import SwiftUI

struct StudentDashboardView: View {
    let username = UserDefaults.standard.string(forKey: "username") ?? "Guest"
    let images = ["Carousel", "Carousel", "Carousel"]
    
    let buttonData = [
        ("Crowd Level", "CrowdLevel", "See crowd levels in areas"),
        ("Canteen", "Canteen", "Order food from canteen"),
        ("Find Hall", "FindHall", "Find exam and lecture halls"),
        ("Navigate Campus", "Navigate", "Find in-campus locations"),
        ("Campus Surfer", "Surfer", "Play a game to earn rewards"),
        ("Campus Events", "Events", "View on-campus events"),
        ("Report Lost Item", "ReportItem", "Find and report lost items"),
        ("Helpdesk & Guide", "Helpdesk", "Find help and support")
    ]
    
    let columns = [
        GridItem(.fixed(170)),
        GridItem(.fixed(170))
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                HStack {
                    Text("Hi, \(username)")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Image("Student")
                }
                
                Text("Welcome to Campus Navigator")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.gray)
                
                Text("Upcoming Events")
                    .font(.system(size: 20, weight: .bold))
                
                // Carousel
                TabView {
                    ForEach(images, id: \.self) { image in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 200)
                            .cornerRadius(10)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 220)
                
                Text("Explore App")
                    .font(.system(size: 20, weight: .bold))
                
                // Grid Layout for Buttons
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(buttonData, id: \.0) { button in
                        ButtonView(title: button.0, imageName: button.1, description: button.2)
                    }
                }
            }
            .padding(20)
        }
    }
}

//Button Component
struct ButtonView: View {
    let title: String
    let imageName: String
    let description: String

    var body: some View {
        Button(action: {
            print("\(title) tapped!")
        }) {
            VStack {
                Image(imageName)
                Text(title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
            }
            .frame(width: 200, height: 140)
        }
    }
}

#Preview {
    StudentDashboardView()
}

