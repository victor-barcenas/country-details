//
//  Endpoints.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import Foundation

struct Endpoints {
    static let api = "https://restcountries.com/v2"
    struct Country {
        static let list = Endpoints.api + "/all"
        static let detail = Endpoints.api + "/name/"
    }
}
