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

    var body: some View {
        VStack {
            Image ("Image")
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
            .background(Color.accents)
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
                        .foregroundColor(Color.primarys)
                        .underline()
                }
                .padding(.vertical, 15)
            }
        
        }
        .padding(.horizontal, 32)
    }

    private func authenticateUser() {
        let userManager = UserManager()
        
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
