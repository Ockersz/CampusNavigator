//
//  ExamSchedule.swift
//  CampusNavigator
//
//  Created by Siluni 025 on 2025-02-26.
//

import SwiftUI

// Exam Model
struct Exam: Identifiable {
    let id = UUID()
    let title: String
    let location: String
    let batchCode: String
    let time: String
}

// Exam Schedule View
struct ExamSchedule: View {
    let exams: [Exam] = [
        Exam(title: "Programming and Data Structures 2",
             location: "PC 03 - 4th Floor",
             batchCode: "BSCCOMP32.2P",
             time: "09:00AM - 12:00PM"),
        
        Exam(title: "Database Systems",
             location: "LT 05 - 2nd Floor",
             batchCode: "BSCCOMP45.3P",
             time: "01:00PM - 03:00PM"),
        
        Exam(title: "Software Engineering",
             location: "PC 02 - 3rd Floor",
             batchCode: "BSCCOMP29.2P",
             time: "03:30PM - 05:30PM")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ExamHeaderView()
                
                ForEach(exams) { exam in
                    ExamItem(exam: exam)
                }
            }
            .padding(20)
        }
    }
}

// Header View Component
struct ExamHeaderView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Exam Schedule")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

// Exam Item View Component
struct ExamItem: View {
    let exam: Exam
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 3) {
                Text(exam.title)
                    .font(.system(size: 18, weight: .semibold))
                
                Text(exam.location)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.blue)
                    .padding(.bottom, 1)
                
                Text(exam.batchCode)
                    .font(.system(size: 13, weight: .regular))
                
                Text(exam.time)
                    .font(.system(size: 13, weight: .regular))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            ExamNavigateButton()
        }
    }
}

// Navigate Button Component
struct ExamNavigateButton: View {
    var body: some View {
        Button {
            print("Navigate clicked!")
        } label: {
            Image(systemName: "location.fill")
                .imageScale(.large)
                .padding()
        }
    }
}

#Preview {
    ExamSchedule()
}
