//
//  Untitled.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

struct BankDetail: Codable {
    let bank: String
    let ifsc: String
    let branch: String
    let address: String
    let contact: String?
    let city: String
    let rtgs: Bool
    let neft: Bool
    let imps: Bool
    let upi: Bool
    let micr: String?
    let swift: String?
    let bankcode: String
    let district: String
    let state: String
    
    enum CodingKeys: String, CodingKey {
        case bank = "BANK"
        case ifsc = "IFSC"
        case branch = "BRANCH"
        case address = "ADDRESS"
        case contact = "CONTACT"
        case city = "CITY"
        case rtgs = "RTGS"
        case neft = "NEFT"
        case imps = "IMPS"
        case upi = "UPI"
        case micr = "MICR"
        case swift = "SWIFT"
        case bankcode = "BANKCODE"
        case district = "DISTRICT"
        case state = "STATE"
    }
}
