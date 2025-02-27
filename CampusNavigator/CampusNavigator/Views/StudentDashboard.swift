//
//  StudentDashboard.swift
//  CampusNavigator
//
//  Created by Siluni 025 on 2025-02-21.
//

import SwiftUI

struct StudentDashboardView: View {
    @Binding var selectedTab: Int
    
    let username = UserDefaults.standard.value(forKey: "LoggedUserName") ?? "Guest"
    let images = ["Carousel", "Carousel", "Carousel"]
    
    let buttonData: [(String, String, String, Int?, AnyView)] = [
        ("Crowd Level", "CrowdLevel", "See crowd levels in areas", 1, AnyView(CrowdLevels())),
        ("Canteen", "Canteen", "Order food from canteen", 2, AnyView(CanteenView())),
        ("Navigate Campus", "Navigate", "Find in-campus locations", nil, AnyView(FindHallView())),
        ("Campus Surfer", "Surfer", "Play a game to earn rewards", nil, AnyView(CampusSurfer()))
    ]
    
    let buttonRowData: [(String, String, String, AnyView)] = [
        ("Campus Events", "Events", "View on-campus events", AnyView(AllEvents())),
        ("Report Lost Item", "ReportItem", "Find and report lost items", AnyView(AllEvents())),
        ("Helpdesk & Guide", "Helpdesk", "Find help and support guides", AnyView(AllEvents()))
    ]
    
    let columns = [GridItem(.fixed(170)), GridItem(.fixed(170))]
    let column2 = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20)]
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Hi, \(username)")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        NavigationLink(
                            destination: LoginView(
                                isAuthenticated: .constant(false)
                            )
                        ){
                            Image("Student")
                        }
                    }
                    
                    Text("Welcome to Campus Navigator")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text("You have")
                        Text("029 credits")
                            .foregroundColor(Color.credits)
                        
                        Button(action: {
                            selectedTab = 3
                        }) {
                            Text("Redeem Now")
                                .foregroundColor(Color.secondarys)
                                .padding(.leading, 50)
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
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(buttonData, id: \.0) { button in
                            ButtonView(
                                title: button.0,
                                imageName: button.1,
                                description: button.2,
                                selectedTab: $selectedTab,
                                tabIndex: button.3,
                                destination: button.4
                            )
                        }
                    }
                    
                    LazyVGrid(columns: column2, spacing: 16) {
                        ForEach(buttonRowData, id: \.0) { button in
                            ButtonView2(
                                title: button.0,
                                imageName: button.1,
                                description: button.2,
                                destination: button.3
                            )
                        }
                    }
                }
                .padding(20)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ButtonView: View {
    let title: String
    let imageName: String
    let description: String
    @Binding var selectedTab: Int
    let tabIndex: Int?
    let destination: AnyView
    
    var body: some View {
        if let tabIndex = tabIndex {
            Button(action: {
                selectedTab = tabIndex
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
        } else {
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
}

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
                    .frame(width: 50, height: 50)
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
    StudentDashboardView(selectedTab: .constant(0))
}
