//
//  LoginResponse.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import Foundation

struct LoginResponse: Codable {
    let succeed: Bool
    let token: String
}
