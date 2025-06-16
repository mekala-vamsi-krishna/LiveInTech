//
//  PincodeLookupView.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import SwiftUI

struct PincodeLookupView: View {
    @State private var pincode: String = ""
    @State private var result: PincodeResult?
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Enter Indian PIN Code")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        TextField("e.g. 110001", text: $pincode)
                            .keyboardType(.numberPad)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                            )
                            .onChange(of: pincode) { newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                if filtered.count > 6 {
                                    pincode = String(filtered.prefix(4))
                                } else {
                                    pincode = filtered
                                }
                            }
                        
                        Button(action: fetchPincodeData) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .foregroundColor(pincode.count == 6 ? .blue : .gray)
                        }
                        .disabled(pincode.count != 6)
                    }
                }
                .padding(.horizontal)
                
                if isLoading {
                    ProgressView("Fetching...")
                        .padding()
                }
                
                if let result = result {
                    VStack(alignment: .leading, spacing: 12) {
                        ModernInfoListView(result: result)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(14)
                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    .padding(.horizontal)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                
                if let error = errorMessage {
                    Text("\(error)")
                        .foregroundColor(.red)
                        .padding(.top)
                }
                
                Spacer()
            }
            .navigationTitle("PIN Code Finder")
        }
    }

    func fetchPincodeData() {
        guard let url = URL(string: "https://api.postalpincode.in/pincode/\(pincode)") else {
            errorMessage = "Invalid URL"
            return
        }
        
        isLoading = true
        errorMessage = nil
        result = nil
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false
                if let error = error {
                    errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                guard let data = data else {
                    errorMessage = "No data received"
                    return
                }
                do {
                    let decoded = try JSONDecoder().decode([PincodeAPIResponse].self, from: data)
                    if let postOffice = decoded.first?.PostOffice?.first {
                        result = PincodeResult(
                            region: postOffice.Name,
                            district: postOffice.District,
                            state: postOffice.State,
                            deliveryStatus: postOffice.DeliveryStatus
                        )
                    } else {
                        errorMessage = "No data found for this PIN"
                    }
                } catch {
                    errorMessage = "Failed to decode response"
                }
            }
        }.resume()
    }
}

#Preview {
    PincodeLookupView()
}
