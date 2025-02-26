
import SwiftUI

struct FindHallView: View {
    var body: some View {
            
            VStack(alignment: .leading, spacing: 20){
                HStack{
                    Text("Navigate Campus")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    
                }
                
                Text("Find on-campus locations and lecture halls")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                VStack(spacing:15){
                    FindHallCard(title: "Navigation", subtitle: "Find in-campus locations easily", icon: "location")
                    FindHallCard(title: "Lectures", subtitle: "Find lecture halls today's schedule", icon: "book")
                    FindHallCard(title: "Exams", subtitle: "Find exams held today", icon: "doc.text")
                }
                
                Spacer()
            }
            .padding()
    }
}

struct FindHallCard: View {
    
    let title: String
    let subtitle: String
    let icon: String
    
    var body: some View {
        HStack{
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.primarys)
            VStack(alignment: .leading){
                Text(title)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}

struct FindHallView_Previews : PreviewProvider{
    static var previews: some View{
        FindHallView()
    }
}
