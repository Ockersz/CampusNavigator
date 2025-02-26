//
//  OrdersView.swift
//  CampusNavigator
//
//  Created by suresh 030 on 2025-02-25.
//

import SwiftUI

struct Order: Identifiable {
    let id = UUID()
    let orderNumber: String
    let timeReceived: String
    let completedTime: String
    let items: [String]
    let total: String
}

struct OrdersView: View {
    let orders: [Order] = [
        Order(orderNumber: "#000", timeReceived: "10:55 AM", completedTime: "11:05 AM",
              items: ["Rice and Curry Chicken x 1", "Milo x 1", "Sun Crush Apple x 1"], total: "LKR 550"),
        Order(orderNumber: "#000", timeReceived: "10:55 AM", completedTime: "11:05 AM",
              items: ["Rice and Curry Chicken x 1", "Milo x 1", "Sun Crush Apple x 1"], total: "LKR 550"),
        Order(orderNumber: "#002", timeReceived: "10:55 AM", completedTime: "11:05 AM",
              items: ["Rice and Curry Chicken x 1", "Milo x 1", "Sun Crush Apple x 1"], total: "LKR 550"),
    ]
   
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your Orders")
                .font(.largeTitle)
                .fontWeight(.bold)
           
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(orders) { order in
                        OrderCard(order: order)
                    }
                }
                .padding(.top, 10)
            }
           
            Spacer()
        }
        .padding()
    }
}

struct OrderCard: View {
    let order: Order
   
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Order \(order.orderNumber)")
                .font(.headline)
           
            Text("Time received: \(order.timeReceived)")
                .font(.subheadline)
                .foregroundColor(.gray)
           
            Text("Completed Time: \(order.completedTime)")
                .font(.subheadline)
                .foregroundColor(.gray)
           
            VStack(alignment: .leading) {
                ForEach(order.items, id: \.self) { item in
                    Text("• \(item)")
                        .font(.body)
                }
            }
           
            Text("Total: \(order.total)")
                .fontWeight(.bold)
                .padding(.top, 5)
           
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}

struct YourOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
