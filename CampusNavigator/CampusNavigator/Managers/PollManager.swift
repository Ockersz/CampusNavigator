//
//  PollManager.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-21.
//
import Foundation

struct Poll: Codable, Identifiable {
    var id: Int
    var locationId: Int
    var userId: Int
    var vote: Int
    var date: String
}

class PollManager: ObservableObject {
    @Published private var polls: [Poll] = []
    
    init() {
        loadPolls()
    }
    
    private func getFilePath() -> URL {
        let fileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return directory.appendingPathComponent("polls.json")
    }
    
    private func loadPolls() {
        let filePath = getFilePath()
        
        if !FileManager.default.fileExists(atPath: filePath.path) {
            print("polls.json not found, initializing empty polls list")
            self.polls = []
            return
        }
        
        guard let data = try? Data(contentsOf: filePath) else {
            print("Failed to read polls.json")
            return
        }
        
        let decoder = JSONDecoder()
        if let loadedPolls = try? decoder.decode([Poll].self, from: data) {
            DispatchQueue.main.async {
                self.polls = loadedPolls
            }
        } else {
            print("Failed to decode polls from JSON")
        }
    }
    
    private func savePolls() {
        let filePath = getFilePath()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(polls)
            try data.write(to: filePath, options: .atomic)
            print("Successfully saved polls to file")
        } catch {
            print("Failed to save polls: \(error)")
        }
    }
    
    func getAllPolls() -> [Poll] {
        return polls
    }
    
    func addPoll(locationId: Int, userId: Int, vote: Int, date: String) -> Bool {
        let maxId = polls.map({ $0.id }).max() ?? 0
        
        let newPoll = Poll(
            id: maxId + 1,
            locationId: locationId,
            userId: userId,
            vote: vote,
            date: date
        )
        
        polls.append(newPoll)
        savePolls()
        
        return true
    }
    
    func getLastPollByUser(locationId: Int, userId: Int) -> Poll? {
        return polls.filter { $0.locationId == locationId && $0.userId == userId }
            .sorted { $0.date > $1.date }
            .first
    }
    
    func getMostFrequentVoteForLocation(locationId: Int) -> Int {
        let locationPolls = polls.filter { $0.locationId == locationId }
        guard !locationPolls.isEmpty else {
            return 0
        }
        
        let voteCounts = locationPolls.reduce(into: [Int: Int]()) { counts, poll in
            counts[poll.vote, default: 0] += 1
        }
        
        return voteCounts.max(by: { $0.value < $1.value })?.key ?? 0
    }
}
