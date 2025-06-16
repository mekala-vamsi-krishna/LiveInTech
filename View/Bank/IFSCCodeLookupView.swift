//
//  IFSCCodeLookupView.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import SwiftUI

struct IFSCCodeLookupView: View {
    @StateObject private var ifscService = IFSCService()
    @State private var ifscCode = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        Image(systemName: "building.columns.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.blue)
                        
                        Text("Bank Details Finder")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Enter IFSC code to get bank information")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Label("IFSC Code", systemImage: "number.circle.fill")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack {
                            TextField("Enter IFSC Code (e.g., SBIN0000001)", text: $ifscCode)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .focused($isTextFieldFocused)
                                .autocapitalization(.allCharacters)
                                .disableAutocorrection(true)
                                .onSubmit {
                                    searchBankDetails()
                                }
                            
                            Button(action: searchBankDetails) {
                                Image(systemName: "magnifyingglass")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 44, height: 44)
                                    .background(Color.blue)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            .disabled(ifscCode.isEmpty || ifscService.isLoading)
                        }
                    }
                    .padding(.horizontal)
                    
                    if ifscService.isLoading {
                        VStack(spacing: 16) {
                            ProgressView()
                                .scaleEffect(1.2)
                            Text("Fetching bank details...")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                    }
                    
                    if let errorMessage = ifscService.errorMessage {
                        VStack(spacing: 12) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.title2)
                                .foregroundColor(.orange)
                            
                            Text(errorMessage)
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .background(Color.orange.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                    }
                    
                    if let bankDetail = ifscService.bankDetail {
                        BankDetailView(bankDetail: bankDetail)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 20)
                }
            }
            .navigationTitle("IFSC Lookup")
            .navigationBarTitleDisplayMode(.inline)
            .refreshable {
                if !ifscCode.isEmpty {
                    ifscService.fetchBankDetails(ifscCode: ifscCode)
                }
            }
        }
    }
    
    private func searchBankDetails() {
        isTextFieldFocused = false
        ifscService.fetchBankDetails(ifscCode: ifscCode)
    }
}

#Preview {
    IFSCCodeLookupView()
}
