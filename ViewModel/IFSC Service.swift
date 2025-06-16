//
//  IFSC Service.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import Foundation

class IFSCService: ObservableObject {
    @Published var bankDetail: BankDetail?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchBankDetails(ifscCode: String) {
        guard !ifscCode.isEmpty else {
            errorMessage = "Please enter a valid IFSC code"
            return
        }
        
        isLoading = true
        errorMessage = nil
        bankDetail = nil
        
        let urlString = "https://ifsc.razorpay.com/\(ifscCode.uppercased())"
        
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid IFSC code format"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "Network error: \(error.localizedDescription)"
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    self?.errorMessage = "Invalid response"
                    return
                }
                
                if httpResponse.statusCode == 404 {
                    self?.errorMessage = "IFSC code not found. Please check and try again."
                    return
                }
                
                guard httpResponse.statusCode == 200 else {
                    self?.errorMessage = "Server error: \(httpResponse.statusCode)"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                do {
                    let bankDetail = try JSONDecoder().decode(BankDetail.self, from: data)
                    self?.bankDetail = bankDetail
                } catch {
                    self?.errorMessage = "Failed to parse bank details: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}
