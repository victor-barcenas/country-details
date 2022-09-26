//
//  Country.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import Foundation

struct Country: Codable {
    let name: String
    let alpha2Code: String
    let alpha3Code: String
    let region: String
    let flags: Flag
}

struct Flag: Codable {
    let png: String
}
