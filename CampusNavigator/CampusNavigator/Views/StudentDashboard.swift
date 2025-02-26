//
//  StudentDashboard.swift
//  CampusNavigator
//
//  Created by Siluni 025 on 2025-02-21.
//

import SwiftUI

struct StudentDashboardView: View {
    let username = UserDefaults.standard.value(forKey: "LoggedUserName") ?? "Guest"
    let images = ["Carousel", "Carousel", "Carousel"]
    let buttonData: [(String, String, String, AnyView)] = [
        ("Crowd Level", "CrowdLevel", "See crowd levels in areas", AnyView(CrowdLevels())),
        ("Canteen", "canteen", "Order food from canteen", AnyView(LoginView())),
        ("Navigate Campus", "Navigate", "Find in-campus locations", AnyView(LoginView())),
        ("Campus Surfer", "Surfer", "Play a game to earn rewards", AnyView(LoginView()))
    ]
    let buttonRowData: [(String, String, String, AnyView)] = [
        ("Campus Events", "Events", "View on-campus events",
         AnyView(AllEvents())),
        ("Report Lost Item", "ReportItem", "Find and report lost items",
         AnyView(AllEvents())),
        (
            "Helpdesk & Guide",
            "Helpdesk",
            "Find help and support guides",
            AnyView(AllEvents())
        )
    ]
    
    let columns = [
        GridItem(.fixed(170)),
        GridItem(.fixed(170))
    ]
    let column2 = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack {
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
                    
                    HStack{
                        Text("You have")
                        Text("029 credits")
                            .foregroundColor(Color.credits)
                        NavigationLink(destination: AnyView(RedeemView())){
                            Text("Redeem Now")
                                .foregroundColor(Color.secondarys)
                                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))
                                .underline()
                                .bold()
                        }
                    }
                    .padding()
                    .background(Color.boxBG)
                    .frame(width: 370, height: 52)
                    .cornerRadius(11)
                    
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
                    
                    // Grid Layout for Main Features
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(buttonData, id: \.0) { button in
                            ButtonView(
                                title: button.0,
                                imageName: button.1,
                                description: button.2,
                                destination: button.3
                            )
                        }
                    }
                    // Grid Layout for Additional Features
                    LazyVGrid(columns: column2, spacing: 16) {
                        ForEach(buttonRowData, id: \.0) { button in
                            ButtonView2(title: button.0, imageName: button.1, description: button.2,
                                        destination: button.3
                            )
                        }
                    }
                }
                .padding(20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// Button Component
struct ButtonView: View {
    let title: String
    let imageName: String
    let description: String
    let destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
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
// Button2 Component
struct ButtonView2: View {
    let title: String
    let imageName: String
    let description: String
    let destination: AnyView

    var body: some View {
        NavigationLink(destination: destination) {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50 )
                Text(title)
                    .font(.system(size: 13))
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                Text(description)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .frame(maxWidth: 120)
            }
            .frame(width: 180, height: 140)
        }
    }
}

#Preview {
    StudentDashboardView()
}

