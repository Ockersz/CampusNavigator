//
//  CrowdStatusView.swift
//  CampusNavigator
//
//  Created by Shahein Ockersz on 2025-02-24.
//

import SwiftUI

struct CrowdStatusView: View {
    let mostFrequentVote: Int
    
    var body: some View {
        GeometryReader { geometry in
            let imageSize = min(geometry.size.width * 0.3, 120)
            let textSize = min(geometry.size.width * 0.08, 20)
            
            VStack {
                if mostFrequentVote == 1 {
                    Image("happyVote")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize, height: imageSize)
                    Text("Not Soo Crowded. Go Ahead!")
                        .font(.system(size: textSize))
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("Secondary"))
                } else if mostFrequentVote == 2 {
                    Image("neutralVote")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize, height: imageSize)
                    Text("Bit Crowded. Better Hurry!")
                        .font(.system(size: textSize))
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("MidCrowd"))
                } else if mostFrequentVote == 3 {
                    Image("sadVote")
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize, height: imageSize * 0.8)
                    Text("Too Crowded. Best Find Another Time!")
                        .font(.system(size: textSize))
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 150)
    }
}
