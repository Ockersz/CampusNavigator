//
//  LectureSchedule.swift
//  CampusNavigator
//
//  Created by Siluni 025 on 2025-02-26.
//

import SwiftUI

struct Lecture: Identifiable {
    let id = UUID()
    let title: String
    let location: String
    let courseCode: String
    let time: String
    let lecturer: String
}

struct LectureSchedule: View {
    @State private var searchText: String = ""
    
    let lectures: [Lecture] = [
        Lecture(title: "Programming and Data Structures 2",
                location: "PC 03 - 4th Floor",
                courseCode: "BSCCOMP32.2P",
                time: "09:00AM - 12:00PM",
                lecturer: "T.S.P WEERASINGHE"),
        
        Lecture(title: "Database Systems",
                location: "LT 05 - 2nd Floor",
                courseCode: "BSCCOMP45.3P",
                time: "01:00PM - 03:00PM",
                lecturer: "D.A. FERNANDO"),
        
        Lecture(title: "Software Engineering",
                location: "PC 02 - 3rd Floor",
                courseCode: "BSCCOMP29.2P",
                time: "03:30PM - 05:30PM",
                lecturer: "M.S. JAYAWARDENA")
    ]
    
    var filteredLectures: [Lecture] {
        if searchText.isEmpty {
            return lectures
        } else {
            return lectures.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.location.localizedCaseInsensitiveContains(searchText) ||
                $0.courseCode.localizedCaseInsensitiveContains(searchText) ||
                $0.lecturer.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HeaderView()
                    SearchBar(searchText: $searchText)
                    
                    ForEach(filteredLectures) { lecture in
                        LectureItem(lecture: lecture)
                    }
                }
                .padding(20)
            }
        }
    }
}

struct HeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Lecture Schedule")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search lectures...", text: $searchText)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
        .padding(.vertical, 5)
    }
}

struct LectureItem: View {
    let lecture: Lecture
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 3) {
                Text(lecture.title)
                    .font(.system(size: 18, weight: .semibold))
                
                Text(lecture.location)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.blue)
                    .padding(.bottom, 1)
                
                Text(lecture.courseCode)
                    .font(.system(size: 13, weight: .regular))
                
                Text(lecture.time)
                    .font(.system(size: 13, weight: .regular))
                
                Text(lecture.lecturer)
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            
            NavigateButton()
            
        }
    }
}

struct NavigateButton: View {
    var body: some View {
        NavigationLink(destination: NavigationGuide() ){
            Image(systemName: "location.fill")
                .imageScale(.large)
                .padding()
        }
    }
}

#Preview {
    LectureSchedule()
}
