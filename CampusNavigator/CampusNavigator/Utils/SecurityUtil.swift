//
//  SecurityUtil.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-18.
//

import Foundation
import CryptoKit

class SecurityUtil {
    private let key = SymmetricKey(size: .bits256)
    
    func encrypt(input: String) -> String? {
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
        do {
            guard let inputData = Data(base64Encoded: input),
                  let sealedBox = try? AES.GCM.SealedBox(combined: inputData) else {
                return nil
            }
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Decryption error: \(error.localizedDescription)")
            return nil
        }
    }
        
    func compare(hash: String, input: String) -> Bool {
        let decryptedData = decrypt(input: hash)
        
        if input == decryptedData {
            return true
        } else {
            return false
        }
    }
}
