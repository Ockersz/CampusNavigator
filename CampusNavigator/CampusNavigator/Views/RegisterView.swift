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
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Image ("Image")
                Text("Sign Up")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.largeTitle)
                    .bold()
                
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 10)
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 10)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 10)
                
                SecureField("Confirm password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 10)
                
                Button("Sign up") {
                    registerUser()
                }
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity, maxHeight: 44)
                .background(Color.accents)
                .foregroundColor(.black)
                .cornerRadius(8)
                .padding(.top, 20)
                
                
                HStack {
                    Text("Already a member?")
                    Button("Login"){
                        presentationMode.wrappedValue.dismiss()
                    }
                    .underline()
                    .font(.headline)
                    .foregroundColor(.blue)
                }
                .padding(.vertical, 15)
                
                Text("By Signing up, you are creating a Patron account and agree to Patron’s Terms and Privacy Policy.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 32)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .navigationBarBackButtonHidden(true)
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
