//
//  HomeCardView.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import SwiftUI

struct HomeCardView: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding()
                .background(color.opacity(0.2))
                .clipShape(Circle())
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.subheadline)
                    
                    .foregroundColor(.gray)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}


#Preview {
    HomeCardView(title: "Title", subtitle: "subtitle", icon: "chevron.right", color: .blue)
}
