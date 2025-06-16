//
//  PublicHolidayModel.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import Foundation

struct PublicHoliday: Codable, Identifiable, Equatable {
    var id = UUID()
    let date: String
    let localName: String
    let name: String
    let countryCode: String
    let fixed: Bool
    let global: Bool
    let counties: [String]?
    let launchYear: Int?
    let types: [String]
}
