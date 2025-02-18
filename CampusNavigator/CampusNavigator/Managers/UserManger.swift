//
//  UserManger.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-18.
//

import Foundation

struct User: Codable {
    var id: UUID
    var fullName: String
    var email: String
    var password: String
    var userType: String
}

class UserManager {
    private var users: [User] = []
    private let fileName: String

    init() {
        self.fileName = "/Data/user.json"
        loadUsers()
    }

    private func getFilePath() -> URL {
        let fileManager = FileManager.default
        let currentPath = fileManager.currentDirectoryPath
        let filePath = URL(fileURLWithPath: currentPath).appendingPathComponent(fileName)
        return filePath
    }

    private func loadUsers() {
        let filePath = getFilePath()
        guard let data = try? Data(contentsOf: filePath) else { return }
        let decoder = JSONDecoder()
        if let loadedUsers = try? decoder.decode([User].self, from: data) {
            self.users = loadedUsers
        }
    }

    private func saveUsers() {
        let filePath = getFilePath()
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(users) {
            try? data.write(to: filePath)
        }
    }

    // Create
    func addUser(_ user: User) {
        users.append(user)
        saveUsers()
    }

    // Read
    func getUser(byId id: UUID) -> User? {
        return users.first { $0.id == id }
    }

    func getAllUsers() -> [User] {
        return users
    }

    // Update
    func updateUser(_ updatedUser: User) {
        if let index = users.firstIndex(where: { $0.id == updatedUser.id }) {
            users[index] = updatedUser
            saveUsers()
        }
    }

    // Delete
    func deleteUser(byId id: UUID) {
        users.removeAll { $0.id == id }
        saveUsers()
    }
}
