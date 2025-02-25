//
//  PollManager.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-21.
//
import Foundation

struct Polls : Codable, Identifiable {
    var id: Int
    var locationId: Int
    var userId: Int
    var vote: Int
    var date: String
}

class PollManager : ObservableObject{
    @Published var polls: [Polls] = []
    var dateHelper: DateHelper = DateHelper()
    
    init() {
        loadPolls()
    }
    
    private func getFilePath() -> URL {
        return URL(fileURLWithPath: "/Users/shaheinockersz/dev/CampusNavigator/CampusNavigator/CampusNavigator/Data/polls.json")
    }
    
    private func loadPolls() {
        guard let filePath = Bundle.main.url(forResource: "polls", withExtension: "json"),
            let data = try? Data(contentsOf: filePath) else {
            print("polls.json not found in the bundle")
            return
        }
        
        let decoder = JSONDecoder()
        if let loadedPolls = try? decoder.decode([Polls].self, from: data) {
            DispatchQueue.main.async {
                self.polls = loadedPolls
            }
            print("Loaded \(loadedPolls.count) locations")
        } else {
            print("Failed to decode locations from JSON")
        }
    }

    
//    private func loadPolls() {
//        let filePath = getFilePath()
//        
//        guard FileManager.default.fileExists(atPath: filePath.path),
//              let data = try? Data(contentsOf: filePath) else {
//            return
//        }
//        
//        let decoder = JSONDecoder()
//        if let loadedPolls = try? decoder.decode([Polls].self, from: data) {
//            DispatchQueue.main.async {
//                self.polls = loadedPolls
//            }
//        } else {
//            print("Failed to decode locations from data")
//        }
//    }
    
    private func savePolls(){
        let filePath = getFilePath()
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(polls) {
            try? data.write(to: filePath)
        }
        
        loadPolls()
    }
    
    func addPoll(locationId: Int, userId: Int, vote: Int, date: String) -> Bool{
        
      
        let maxId = polls.map({$0.id}).max() ?? 0
        
        let newPoll : Polls = Polls(
            id: maxId + 1,
            locationId: locationId,
            userId: userId,
            vote: vote,
            date: date
        )
        
        polls.append(newPoll)
        self.savePolls()
        
        return true
    }
    
    func getLastPollByUser(locationId: Int, userId: Int) -> Polls? {
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
        
        if let (mostFrequentVote, _) = voteCounts.max(by: { $0.value < $1.value }) {
            return mostFrequentVote
        } else {
            return 0
        }
    }
}
