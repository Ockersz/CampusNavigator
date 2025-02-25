//
//  VoteButton.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-24.
//

import SwiftUI

struct VoteButton: View {
    let emoji: String
    let label: String
    let vote: Int
    let action: (Int) -> Void
    let isDisabled: Bool
    let size: CGFloat
    
    var body: some View {
        Button(action: { action(vote) }) {
            VStack {
                Image(emoji)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size * 0.8, height: size * 0.8)
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .minimumScaleFactor(0.8)
                    .lineLimit(1)
            }
            .frame(width: size, height: size)
            .cornerRadius(10)
        }
        .padding(.horizontal, 5)
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.5 : 1.0)
    }
}
