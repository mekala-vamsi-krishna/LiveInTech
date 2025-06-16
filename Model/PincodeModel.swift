//
//  PincodeModel.swift
//  LiveInTech
//
//  Created by Mekala Vamsi Krishna on 6/16/25.
//

import Swift

struct PincodeAPIResponse: Codable {
    let PostOffice: [PostOfficeInfo]?
}

struct PostOfficeInfo: Codable {
    let Name: String
    let District: String
    let State: String
    let Circle: String?
    let DeliveryStatus: String
}

struct PincodeResult {
    let region: String
    let district: String
    let state: String
    let deliveryStatus: String
}
