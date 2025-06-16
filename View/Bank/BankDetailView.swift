//
//  BankDetailView.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import SwiftUI
import Foundation

struct BankDetailView: View {
    let bankDetail: BankDetail
    
    var body: some View {
        VStack(spacing: 0) {
            DetailRow(iconName: "building.columns", title: "Bank", value: bankDetail.bank)
            DetailRow(iconName: "building.2", title: "Branch", value: bankDetail.branch)
            DetailRow(iconName: "number", title: "IFSC Code", value: bankDetail.ifsc)
            DetailRow(iconName: "map", title: "Address", value: bankDetail.address)
            DetailRow(iconName: "mappin.and.ellipse", title: "City", value: bankDetail.city)
            DetailRow(iconName: "globe.asia.australia", title: "District", value: bankDetail.district)
            DetailRow(iconName: "location", title: "State", value: bankDetail.state)
            
            if let contact = bankDetail.contact, !contact.isEmpty {
                DetailRow(iconName: "phone", title: "Contact", value: contact)
            }
            
            if let micr = bankDetail.micr, !micr.isEmpty {
                DetailRow(iconName: "barcode", title: "MICR Code", value: micr)
            }
            
            if let swift = bankDetail.swift, !swift.isEmpty {
                DetailRow(iconName: "arrow.left.arrow.right", title: "SWIFT Code", value: swift)
            }
            
            DetailRow(iconName: "bolt.horizontal.circle", title: "RTGS", value: bankDetail.rtgs ? "Available" : "Not Available")
            DetailRow(iconName: "arrow.left.arrow.right.circle", title: "NEFT", value: bankDetail.neft ? "Available" : "Not Available")
            DetailRow(iconName: "bitcoinsign.circle", title: "IMPS", value: bankDetail.imps ? "Available" : "Not Available")
            DetailRow(iconName: "creditcard", title: "UPI", value: bankDetail.upi ? "Available" : "Not Available")
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

struct DetailRow: View {
    let iconName: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                    .frame(width: 20)
                
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            
            Spacer()
            
            Text(value)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.white)
        
        Divider()
            .padding(.leading, 16)
    }
}


#Preview {
    BankDetailView(bankDetail: BankDetail(bank: "State Bank of India", ifsc: "SBIN0000001", branch: "KOLKATA MAIN", address: "SAMRIDDHI BHAWAN, 1 STRAND ROAD, KOLKATA 700 001", contact: "9876543210", city: "Kolkata", rtgs: true, neft: true, imps: true, upi: true, micr: "700002021", swift: nil, bankcode: "SBIN", district: "Kolkata", state: "West Bengal"))
}
