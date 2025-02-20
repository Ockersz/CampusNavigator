//
//  ImageHelper.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-18.
//

import UIKit
import Foundation

class ImageHelper {
    
    func saveImage(image: UIImage, eventId: Int) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1.0) else { return false }
        
        let fileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = directory.appendingPathComponent("\(eventId).jpg")
        
        do {
            try data.write(to: filePath)
            return true
        } catch {
            print("Error saving image: \(error.localizedDescription)")
            return false
        }
    }

    func loadImage(eventId: Int) -> UIImage? {
        let fileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = directory.appendingPathComponent("\(eventId).jpg")
        
        if fileManager.fileExists(atPath: filePath.path) {
            return UIImage(contentsOfFile: filePath.path)
        }
        return nil
    }

}
