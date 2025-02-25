//
//  CanteenView.swift
//  CampusNavigator
//
//  Created by suresh 030 on 2025-02-25.
//

import SwiftUI

struct CanteenView: View {
    var body: some View {
        NavigationStack{
            
            VStack(alignment: .leading, spacing: 20){
                HStack{
                    Text("Canteen")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    
                    Button( action: {
                        //cart action
                    }) {
                        Image(systemName: "cart")
                            .font(.title)
                            .foregroundColor(.primarys)
                    }
                    
                }
                
                Text("Avoid queues, Order your food")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                VStack(spacing:15){
                    CanteenCard(title: "Foods & Beverages", subtitle: "Select and Order", icon: "fork.knife")
                    NavigationLink(destination: OrdersView()){
                        CanteenCard(title: "Your Orders", subtitle: "View your ongoing and past Orders", icon: "list.bullet.clipboard")
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct CanteenCard: View {
    
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

struct CanteenView_Previews : PreviewProvider{
    static var previews: some View{
        CanteenView()
    }
}
