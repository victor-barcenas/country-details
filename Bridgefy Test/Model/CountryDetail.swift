//
//  CountryDetail.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 26/09/22.
//

import Foundation

struct CountryDetail: Codable {
    let name: String
    let alpha2Code: String
    let alpha3Code: String
    let region: String
    let flags: Flag
    let capital: String?
    let subregion: String
    let area: Double?
    let latlng: [Double]
    let population: Int64
    let languages: [Language]
    let callingCodes: [String]
    let borders: [String]?
    let timezones: [String]
    let currencies: [Currency]?
    var isStored: Bool?
}

struct Language: Codable {
    let name: String
}

struct Currency: Codable {
    let code: String
    let name: String
    let symbol: String
}
