//
//  LoginError.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import Foundation

struct LoginError: ApiError {
    var code: Int
    var message: String
}
