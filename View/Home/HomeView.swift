//
//  HomeView.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import SwiftUI

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("Home View")
                    .font(.largeTitle.bold())
                    .padding(.top)
                
                NavigationLink(destination: PincodeLookupView()) {
                    HomeCardView(
                        title: "Pincode Lookup",
                        subtitle: "Find region, district, and state by PIN",
                        icon: "location.viewfinder",
                        color: .blue
                    )
                }
                
                NavigationLink(destination: IFSCCodeLookupView()) {
                    HomeCardView(
                        title: "IFSC Code Lookup",
                        subtitle: "Get bank details by IFSC code",
                        icon: "banknote",
                        color: .green
                    )
                }
                
                NavigationLink(destination: PublicHolidayView()) {
                    HomeCardView(
                        title: "Public Holidays Looup",
                        subtitle: "Get public holidays",
                        icon: "beach.umbrella",
                        color: .indigo
                    )
                }
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
    }
}


#Preview {
    HomeView()
}
