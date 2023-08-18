//
//  ResortModel.swift
//  Day99_SnowSeeker
//
//  Created by cem on 18.08.2023.
//

import Foundation

struct ResortModel: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]

    var facilityTypes: [FacilityModel] {
        facilities.map(FacilityModel.init)
    }

    static let allResorts: [ResortModel] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}
