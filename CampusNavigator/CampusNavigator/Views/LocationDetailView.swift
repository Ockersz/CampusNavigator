//
//  LocationDetailView.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-21.
//

import SwiftUI

struct LocationDetailView: View {
    var location: Location
    @ObservedObject var pollManager: PollManager = PollManager()
    @State private var showAlert = false
    @State private var showHTP = false
    @State private var lastPolled: Date? = nil
    @State private var remainingTime: Int = 0
    @State private var mostFrequentVote: Int = 0
    
    var body: some View {
        VStack {
            CrowdStatusView(mostFrequentVote: mostFrequentVote)
           
            PopularTimesView()
            
            if PollHelper.isVoteDisabled(lastPolled: lastPolled) {
                Text("You can vote again in \(remainingTime) seconds")
                    .font(.headline)
                    .foregroundColor(.red)
                    .onAppear(perform: startTimer)
            }
            
            VotingView(
                submitVote: submitVote,
                isVoteDisabled: PollHelper.isVoteDisabled(lastPolled: lastPolled),
                showHTP: $showHTP
            )
        }
        .padding()
        .navigationTitle(location.name)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Thank You!"), message: Text("Your response has been recorded."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showHTP) {
            Alert(
                title: Text("How to Play").underline(true, color: .primary),
                message: Text("You can enter the state of the crowd level. When you interact with the app you receive credits which you can use to redeem rewards in the reward section.\n\nAttention: This system monitors scams and irregular activities. Failure to provide precise information will cause reduction of credits or permanent ban from interacting."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            loadLastPoll()
            loadMostFrequent()
        }
    }
    
    private func submitVote(vote: Int) {
        if PollHelper.submitVote(vote: vote, location: location, pollManager: pollManager) {
            showAlert = true
            lastPolled = Date()
            startTimer()
        }
    }
    
    private func startTimer() {
        PollHelper.startTimer(lastPolled: lastPolled, remainingTime: $remainingTime)
    }
    
    private func loadLastPoll() {
        lastPolled = PollHelper.loadLastPoll(location: location, pollManager: pollManager)
        startTimer()
    }
    
    private func loadMostFrequent() {
        mostFrequentVote = PollHelper.loadMostFrequent(location: location, pollManager: pollManager)
    }
}

#Preview {
    LocationDetailView(location: Location(id: 1, name: "Canteen", description: "Where you have your meals", icon: "canteen"))
}
