import SwiftUI

struct VotingView: View {
    let submitVote: (Int) -> Void
    let isVoteDisabled: Bool
    @Binding var showHTP: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("At Premises? Let us know the state of the crowd.")
                .font(.system(size: 14)) // Smaller font size for better scaling
                .padding(.bottom, 5)
                .minimumScaleFactor(0.8) // Adjusts text dynamically
            
            HStack {
                Text("Earn credits by notifying us.")
                    .font(.system(size: 12))
                    .fontWeight(.thin)
                    .minimumScaleFactor(0.8)
                Spacer()
                Button(action: { showHTP = true }) {
                    Image("howToPlay")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20) // Smaller icon size
                }
            }
        }
        .padding(.horizontal, 10)
        
        GeometryReader { geometry in
            HStack(spacing: 8) {
                let buttonSize = min(geometry.size.width * 0.3, 90)
                
                VoteButton(emoji: "happyVote", label: "Not crowded", vote: 1, action: submitVote, isDisabled: isVoteDisabled, size: buttonSize)
                VoteButton(emoji: "neutralVote", label: "Bit crowded", vote: 2, action: submitVote, isDisabled: isVoteDisabled, size: buttonSize)
                VoteButton(emoji: "sadVote", label: "Super crowded", vote: 3, action: submitVote, isDisabled: isVoteDisabled, size: buttonSize)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 120)
    }
}
