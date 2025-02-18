//
//  LoginView.swift
//  CampusNavigator
//
//  Created by Siluni 025 on 2025-02-18.
//

import SwiftUICore
import SwiftUI

struct LoginView: View {
//    @Binding var isLoggedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Text("New member?")
                NavigationLink(destination: RegisterView()) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .underline()
                }
            }
            
            Button("Login") {
                authenticateUser()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }

    private func authenticateUser() {
        let userManager = UserManager.init()
        
        let (isCorrect, userType) = userManager.loginUser(email: email, password: password)
        if isCorrect {
            alertTitle = "Success"
            alertMessage = "Login successful!"
            showingAlert = true
        } else {
            alertTitle = "Error"
            alertMessage = "Invalid email or password"
            showingAlert = true
        }
    }
}

#Preview {
    LoginView()
}
