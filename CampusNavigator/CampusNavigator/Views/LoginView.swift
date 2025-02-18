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

    var body: some View {
        VStack {
            Text("Login")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle)
                .bold()
                .padding()

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
                print("Logged In")
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 44)
            .background(Color.yellow)
            .foregroundColor(.white)
            .cornerRadius(8)

        }
        .padding()
    }

//    private func authenticateUser() {
//        if email == "test@example.com" && password == "password" {
//            isLoggedIn = true
//        }
//    }
}

#Preview {
    LoginView()
}
