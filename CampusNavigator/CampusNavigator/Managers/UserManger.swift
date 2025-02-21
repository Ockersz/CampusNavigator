//
//  UserManger.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-18.
//

import Foundation

struct User: Codable {
    var id: Int
    var fullName: String
    var email: String
    var password: String
    var userType: String
}

class UserManager {
    private var users: [User] = []
    private let fileName: String

    init() {
            self.fileName = "user.json"
            loadUsers()
        }

        private func getFilePath() -> URL {
            let filePath = URL(filePath: "/Users/shaheinockersz/dev/CampusNavigator/CampusNavigator/CampusNavigator/Data/user.json")
            return filePath
        }

        private func loadUsers() {
            let filePath = getFilePath()

            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: filePath.path) {
                return
            }

            guard let data = try? Data(contentsOf: filePath) else {
                return
            }
         
            let decoder = JSONDecoder()
            if let loadedUsers = try? decoder.decode([User].self, from: data) {
                self.users = loadedUsers
            } else {
                print("Failed to decode users from data")
            }
        }
    
    private func saveUsers() {
        let filePath = getFilePath()
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(users) {
            try? data.write(to: filePath)
        }
    }
    
    func loginUser(email: String, password: String) -> (Bool, String) {
        
       let securityUtil = SecurityUtil()
        
        for user in users {
            
            if user.email == email && securityUtil.compare(hash: user.password, input: password){
                UserDefaults.setValue(user.id, forKey: "LoggedUserId")
                return (true, user.userType)
            }
//            if user.email == email && user.password == password{
//                return (true, user.userType)
//            }
        }
        return (false, "")
    }
    
    func registerUser(fullName: String, email: String, password: String, userType: String) -> (Bool, String) {
        let maxId = users.max(by: { $0.id < $1.id })?.id ?? 0
        let newId = maxId + 1
        let existingUser = users.first { $0.email == email }

        guard existingUser == nil else {
            return (false, "User with this email already exists")
        }
        
        let securityUtil = SecurityUtil()

        let hashedPW = securityUtil.hash(input: password)

        let newUser = User(id: newId, fullName: fullName, email: email, password: hashedPW, userType: userType)
        users.append(newUser)

        saveUsers()
        return (true, "Successfully registered!")
    }
}
