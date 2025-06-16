//
//  InfoRowView.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import SwiftUI

struct InfoRowView: View {
    let title: String
    let value: String
    let icon: String
    let color: LinearGradient
    
    init(title: String, value: String, icon: String = "info.circle", color: LinearGradient) {
        self.title = title
        self.value = value
        self.icon = icon
        self.color = color
    }
    
    var body: some View {
        
        InfoCardView(title: title, value: value, icon: icon, gradient: color)
    }
}

struct InfoCardView: View {
    let title: String
    let value: String
    let icon: String
    let gradient: LinearGradient
    
    init(title: String, value: String, icon: String, gradient: LinearGradient) {
        self.title = title
        self.value = value
        self.icon = icon
        self.gradient = gradient
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                
                Spacer()
                
                Text(title)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                    .textCase(.uppercase)
                    .tracking(0.5)
            }
            
            Text(value)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
        .padding(20)
        .frame(maxWidth: .infinity, minHeight: 100)
        .background(gradient)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

struct ModernInfoListView: View {
    let result: PincodeResult
    
    var body: some View {
        VStack(spacing: 12) {
            InfoRowView(
                title: "Region",
                value: result.region,
                icon: "globe.americas.fill",
                color: LinearGradient(
                    colors: [Color.blue, Color.purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            
            InfoRowView(
                title: "District",
                value: result.district,
                icon: "building.2.fill",
                color: LinearGradient(
                    colors: [Color.green, Color.teal],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            
            InfoRowView(
                title: "State",
                value: result.state,
                icon: "map.fill",
                color: LinearGradient(
                    colors: [Color.orange, Color.red],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            
            InfoRowView(
                title: "Delivery Status",
                value: result.deliveryStatus,
                icon: "shippingbox.fill",
                color: LinearGradient(
                    colors: [Color.pink, Color.purple],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
        .padding(.horizontal)
    }
}

#Preview {
    ModernInfoListView(result: PincodeResult(region: "region", district: "district", state: "state", deliveryStatus: "delivery status"))
}
