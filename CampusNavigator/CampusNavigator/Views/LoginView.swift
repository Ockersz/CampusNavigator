//
//  LoginView.swift
//  CampusNavigator
//
//  Created by Siluni 025 on 2025-02-18.
//

import SwiftUICore
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isLoggedIn = false
    @State private var isAdmin = false
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("Image")
                Text("Login")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .bold()
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 15)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.vertical, 15)
                
                Button("Continue") {
                    authenticateUser()
                }
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity, maxHeight: 44)
                .background(Color("Accents"))
                .foregroundColor(.black)
                .cornerRadius(8)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                
                HStack {
                    Text("New member?")
                    NavigationLink(destination: RegisterView()) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .underline()
                    }
                    .padding(.vertical, 15)
                }
                
                NavigationLink(value: isLoggedIn) {
                    EmptyView()
                }
                .navigationDestination(isPresented: $isLoggedIn) {
                    if(isAdmin){
                        AllEventsStaff()
                    }else{
                        StudentDashboardView(selectedTab: .constant(0))
                    }
                }
                
            }
            .padding(.horizontal, 32)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func authenticateUser() {
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertTitle = "Error"
            alertMessage = "Email and password cannot be empty"
            showingAlert = true
            return
        }
        
        if(email == "admin" && password == "admin"){
            isLoggedIn = true
            isAdmin = true
            isAuthenticated = true
            return
        }
        
        let userManager = UserManager()
        let (isCorrect, _) = userManager.loginUser(email: email, password: password)
        
        if isCorrect {
            isLoggedIn = true
            isAdmin = false
            isAuthenticated = true
        } else {
            alertTitle = "Error"
            alertMessage = "Invalid email or password"
            showingAlert = true
        }
    }
}

