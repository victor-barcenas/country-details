//
//  ApiError.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 23/09/22.
//

import Foundation

protocol ApiError: Error {
    var code: Int { get set }
    var message: String { get set }
}
