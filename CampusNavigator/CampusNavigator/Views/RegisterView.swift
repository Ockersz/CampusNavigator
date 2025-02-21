//
//  RegisterView.swift
//  CampusNavigator
//
//  Created by Siluni 025 on 2025-02-18.
//

import SwiftUICore
import SwiftUI

struct RegisterView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.largeTitle)
                .bold()
            
            TextField("Name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Confirm Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Login") {
                registerUser()
            }
            .padding()
//            .frame(maxWidth: .infinity, maxHeight: 44)
            .background(Color.yellow)
            .foregroundColor(.white)
            .cornerRadius(8)
            
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func registerUser(){
        let userManager = UserManager()
        
        let (isRegistered, message) = userManager.registerUser(fullName: name, email: email, password: password, userType: "student")
        
        if(isRegistered){
            alertTitle = "Success"
            alertMessage = message
            showingAlert = true
        }else{
            alertTitle = "Error"
            alertMessage =  message
            showingAlert = true
        }
    }
}

#Preview {
    RegisterView()
}
