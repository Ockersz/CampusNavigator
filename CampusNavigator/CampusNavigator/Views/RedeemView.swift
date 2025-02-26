import SwiftUI

struct RedeemView: View {
    let buttonData = [
        ("Soda", "Suncrush", "600"),
        ("Milk Packet", "Milk", "500"),
        ("Breakfast", "Breakfast", "1000"),
        ("Lunch", "RiceNCurry", "2000")
    ]
    
    let columns = [
        GridItem(.fixed(170), spacing: 20),
        GridItem(.fixed(170), spacing: 20)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Redeem")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Image("Star")
                    Text("029 credits")
                        .foregroundColor(Color.credits)
                }
                
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(buttonData, id: \.0) { button in
                        ItemView(title: button.0, imageName: button.1, description: button.2)
                            .padding()
                    }
                }
            }
            .padding(20)
        }
    }
}

// Button Component
struct ItemView: View {
    let title: String
    let imageName: String
    let description: String

    var body: some View {
        Button(action: {
            print("\(title) tapped!")
        }) {
            VStack(spacing: 8) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 120)
                
                Text(title)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                
                HStack {
                    Image("Star")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text(description)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)
                }
            }
            .frame(width: 160, height: 140)
        }
    }
}

#Preview {
    RedeemView()
}
