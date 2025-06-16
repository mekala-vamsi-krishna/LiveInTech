//
//  PublicHolidaysView.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import SwiftUI

struct PublicHolidayView: View {
    @State private var year: String = "2023"
    @State private var countryCode: String = "US"
    @State private var holidays: [PublicHoliday] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()

                VStack(spacing: 16) {
                    HStack {
                        TextField("Year (e.g., 2025)", text: $year)
                            .keyboardType(.numberPad)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                            .onChange(of: year) { newValue in
                                let filtered = newValue.filter { $0.isNumber }
                                if filtered.count > 4 {
                                    year = String(filtered.prefix(4))
                                } else {
                                    year = filtered
                                }
                            }

                        TextField("Country (e.g., IN)", text: $countryCode)
                            .textCase(.uppercase)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        
                        Button(action: fetchHolidays) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }

                    Group {
                        if isLoading {
                            ProgressView("Loading Holidays...")
                                .padding()
                        } else if let error = errorMessage {
                            Text(error)
                                .foregroundColor(.red)
                                .padding()
                        } else {
                            List {
                                ForEach(holidays) { holiday in
                                    Section {
                                        HolidayRowView(holiday: holiday)
                                    }
                                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .listRowBackground(Color.white)
                                }
                            }
                            .listStyle(PlainListStyle())
                            .scrollContentBackground(.hidden)
                            .background(Color.white)
                        }
                    }
                    .animation(.easeInOut, value: isLoading)
                    .animation(.easeInOut, value: holidays)
                }
                .padding()
            }
            .navigationTitle("Public Holidays")
        }
    }

    func fetchHolidays() {
        isLoading = true
        errorMessage = nil
        holidays = []

        guard let url = URL(string: "https://date.nager.at/api/v3/PublicHolidays/\(year)/\(countryCode)") else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse else {
                    self.errorMessage = "Invalid response from server"
                    return
                }

                switch httpResponse.statusCode {
                case 200:
                    guard let data = data else {
                        self.errorMessage = "No data received"
                        return
                    }

                    do {
                        self.holidays = try JSONDecoder().decode([PublicHoliday].self, from: data)
                    } catch {
                        self.errorMessage = "Failed to decode holidays"
                    }

                case 204:
                    self.errorMessage = "No holidays found for the given year and country."
                    
                case 400..<500:
                    self.errorMessage = "Client Error (\(httpResponse.statusCode)): Please check your inputs."
                    
                case 500..<600:
                    self.errorMessage = "Server Error (\(httpResponse.statusCode)): Please try again later."

                default:
                    self.errorMessage = "Unexpected Error (\(httpResponse.statusCode))"
                }
            }
        }.resume()
    }

}


#Preview {
    PublicHolidayView()
}
