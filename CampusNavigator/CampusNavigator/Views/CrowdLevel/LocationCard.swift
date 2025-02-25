import SwiftUI
import Foundation

struct LocationCard: View {
    
    var location: Location
    @State private var mostFrequentVote: Int = 0
    @StateObject private var pollManager = PollManager()
    
    @State private var lastPolled: Date? = nil
    @State private var remainingTime: Int = 0
    @State private var showAlert = false
    @State private var showHTP = false
    @State private var timer: Timer? = nil
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack {
                Text(location.name)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(destination: LocationDetailView(location: location)) {
                    HStack {
                        Text("More Details ")
                            .font(.headline)
                            .fontWeight(.regular)
                            .foregroundStyle(Color.blue)
                        Image(systemName: "chevron.right")
                            .foregroundColor(.blue)
                    }
                }
            }
            
            CrowdStatusView(mostFrequentVote: mostFrequentVote)
                .scaledToFit()
            
            if isVoteDisabled() {
                Text("You can vote again in \(remainingTime) seconds")
                    .font(.subheadline)
                    .foregroundColor(.red)
                    .onAppear(perform: startTimer)
            }
            
            VotingView(
                submitVote: submitVote,
                isVoteDisabled: isVoteDisabled(),
                showHTP: $showHTP
            )
            
        }
        .padding()
        .frame(maxWidth: 370, minHeight: 100)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .onAppear {
            Task {
                await fetchMostFrequentVote()  // ✅ Run asynchronously in a safe Task
                loadLastPoll()  // ✅ Ensure previous poll data loads
            }
        }
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
    }
    
    @MainActor
    private func fetchMostFrequentVote() async {
        let vote = PollHelper.loadMostFrequent(location: location, pollManager: pollManager)
        mostFrequentVote = vote
    }
    
    private func submitVote(vote: Int) {
        if PollHelper.submitVote(vote: vote, location: location, pollManager: pollManager) {
            showAlert = true
            lastPolled = Date()
            startTimer()
        }
    }
    
    private func isVoteDisabled() -> Bool {
        if let lastPolled = lastPolled,
           let cooldownEnd = Calendar.current.date(byAdding: .minute, value: 5, to: lastPolled) {
            return Date() < cooldownEnd
        }
        return false
    }
    
    private func startTimer() {
        timer?.invalidate()
        
        if let lastPolled = lastPolled,
           let cooldownEnd = Calendar.current.date(byAdding: .minute, value: 5, to: lastPolled) {
            remainingTime = Int(cooldownEnd.timeIntervalSinceNow)
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                DispatchQueue.main.async {
                    if remainingTime > 0 {
                        remainingTime -= 1
                    } else {
                        timer?.invalidate()
                    }
                }
            }
        }
    }
    
    private func loadLastPoll() {
        let dateHelper = DateHelper()
        if let userId = UserDefaults.standard.value(forKey: "userId") as? Int,
           let lastPoll = pollManager.getLastPollByUser(locationId: location.id, userId: userId) {
            lastPolled = dateHelper.stringToDateNormal(dateString: lastPoll.date)
            startTimer()
        }
    }
}

#Preview {
    LocationCard(location: Location(id: 1, name: "Canteen", description: "Where you have your meals", icon: "canteen"))
}
