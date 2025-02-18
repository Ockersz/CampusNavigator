//
//  SecurityUtil.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-18.
//

import Foundation
import CryptoKit

class SecurityUtil {
    private var key: SymmetricKey?

    init() {
        loadKey()
    }

    private func getFilePath() -> URL {
        return URL(filePath: "/Users/shaheinockersz/dev/CampusNavigator/CampusNavigator/CampusNavigator/Data/keys.json")
    }

    private func loadKey() {
        let filePath = getFilePath()
        let fileManager = FileManager.default

        if !fileManager.fileExists(atPath: filePath.path) {
            print("Key file not found, generating new key...")
            generateAndSaveKey()
            return
        }

        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            if let loadedKeyData = try? decoder.decode([String: String].self, from: data),
               let keyString = loadedKeyData["key"],
               let keyData = Data(base64Encoded: keyString) {
                self.key = SymmetricKey(data: keyData)
                print("Key successfully loaded")
            } else {
                print("Failed to decode key from data")
            }
        } catch {
            print("Error loading key file: \(error.localizedDescription)")
        }
    }

    private func generateAndSaveKey() {
        let newKey = SymmetricKey(size: .bits256)
        let keyData = newKey.withUnsafeBytes { Data(Array($0)) }
        let keyString = keyData.base64EncodedString()
        
        let keyDict: [String: String] = ["key": keyString]
        let encoder = JSONEncoder()
        
        do {
            let data = try encoder.encode(keyDict)
            try data.write(to: getFilePath())
            print("New key generated and saved")
        } catch {
            print("Error saving key: \(error.localizedDescription)")
        }

        self.key = newKey
    }

    func encrypt(input: String) -> String? {
        guard let key = key else {
            print("Encryption key not loaded")
            return nil
        }

        do {
            let inputData = Data(input.utf8)
            let sealedBox = try AES.GCM.seal(inputData, using: key)
            return sealedBox.combined?.base64EncodedString()
        } catch {
            print("Encryption error: \(error.localizedDescription)")
            return nil
        }
    }

    func decrypt(input: String) -> String? {
        guard let key = key else {
            print("Decryption key not loaded")
            return nil
        }

        guard let inputData = Data(base64Encoded: input) else {
            print("Invalid base64 encoded input")
            return nil
        }

        do {
            let sealedBox = try AES.GCM.SealedBox(combined: inputData)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption error: \(error.localizedDescription)")
            return nil
        }
    }

    func hash(input: String) -> String {
        let inputData = Data(input.utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.map { String(format: "%02x", $0) }.joined()
    }

    func compare(hash: String, input: String) -> Bool {
        return hash == self.hash(input: input)
    }
}
