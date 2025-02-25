//
//  PollHelper.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-24.
//


import Foundation
import SwiftUI

struct PollHelper {
    
    static func submitVote(vote: Int, location: Location, pollManager: PollManager) -> Bool {
        let dateHelper = DateHelper()
        if let userId = UserDefaults.standard.value(forKey: "userId") as? Int {
            let now = Date()
            let localTimeString = dateHelper.dateToString(date: now, format: "dd/MM/yyyy HH:mm a")
            return pollManager.addPoll(locationId: location.id, userId: userId, vote: vote, date: localTimeString)
        }
        return false
    }
    
    static func isVoteDisabled(lastPolled: Date?) -> Bool {
        guard let lastPolled = lastPolled,
              let cooldownEnd = Calendar.current.date(byAdding: .minute, value: 5, to: lastPolled) else {
            return false
        }
        return Date() < cooldownEnd
    }
    
    static func startTimer(lastPolled: Date?, remainingTime: Binding<Int>) {
        if let lastPolled = lastPolled,
           let cooldownEnd = Calendar.current.date(byAdding: .minute, value: 5, to: lastPolled) {
            remainingTime.wrappedValue = Int(cooldownEnd.timeIntervalSinceNow)
        }
    }
    
    static func loadLastPoll(location: Location, pollManager: PollManager) -> Date? {
        let dateHelper = DateHelper()
        if let userId = UserDefaults.standard.value(forKey: "userId") as? Int,
           let lastPoll = pollManager.getLastPollByUser(locationId: location.id, userId: userId) {
            return dateHelper.stringToDateNormal(dateString: lastPoll.date)
        }
        return nil
    }
    
    static func loadMostFrequent(location: Location, pollManager: PollManager) -> Int {
        return pollManager.getMostFrequentVoteForLocation(locationId: location.id) ?? 0
    }
}
