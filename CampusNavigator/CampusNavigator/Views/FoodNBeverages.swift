//
//  FoodNBeverages.swift
//  CampusNavigator
//
//  Created by Siluni 025 on 2025-02-25.
//

import SwiftUI

struct FoodNBeveragesView: View {
    let itemData = [
        ("RiceCurry", "Rice & Curry", "3 curries and chicken", "LKR 280"),
        ("FriedRice", "Fried Rice", "Chopsuey and chicken", "LKR 400"),
    ]
    
    let drinkData = [
        ("Suncrush", "Suncrush", "Refreshing fruit juice", "LKR 150"),
        ("Milo", "Milo", "Hot or cold Milo", "LKR 120")
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Header
                Text("Food & Beverages")
                    .font(.largeTitle)
                    .bold()
                
                Text("Avoid queues, Order your food")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.gray)
                
                // Food Section
                HStack {
                    Text("Food")
                        .font(.system(size: 20, weight: .bold))
                        .padding(.vertical, 10)
                    Spacer()
                    HStack {
                        Text("See All")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(Color.primarys)
                }
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(itemData, id: \.0) { item in
                        FoodItemView(imageName: item.0, title: item.1, description: item.2, price: item.3)
                    }
                }
                
                // Beverages Section
                VStack {
                    HStack {
                        Text("Beverages")
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        HStack {
                            Text("See All")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(Color.primarys)
                    }
                    
                    // Food Items Grid
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(drinkData, id: \.0) { item in
                            FoodItemView(imageName: item.0, title: item.1, description: item.2, price: item.3)
                        }
                    }
                }
                .padding(EdgeInsets(top: 30, leading: 0, bottom: 0, trailing: 0))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
            

        }
    }
}

// Item Component
struct FoodItemView: View {
    let imageName: String
    let title: String
    let description: String
    let price: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
                .cornerRadius(10)
            
            Text(title)
                .font(.headline)
            
            Text(description)
                .font(.footnote)
                .foregroundColor(.gray)
                .lineLimit(2)
            
            Text(price)
                .font(.subheadline)
                .bold()
                .padding(.vertical, 2)
            
            HStack {
                HStack {
                    Button("", systemImage: "plus") {
                        print("Item increased")
                    }
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.secondarys)
                        .cornerRadius(5)
                    
                    Spacer()
                    Text("1")
                    Spacer()
                    
                    Button("", systemImage: "minus") {
                        print("Item decreased")
                    }
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.secondarys)
                        .cornerRadius(5)
                }
                .background(Color.boxBG)
                .frame(width: 120, height: 40)
                .cornerRadius(5)
                
                Button("", systemImage: "cart") {
                    print("Added to cart!")
                }
                .foregroundStyle(Color.secondarys)
                .frame(width: 40, height: 40)
            }
            .frame(alignment: .center)
        }
        .frame(width: 160, alignment: .leading)
        .cornerRadius(8)
    }
}

#Preview {
    FoodNBeveragesView()
}
