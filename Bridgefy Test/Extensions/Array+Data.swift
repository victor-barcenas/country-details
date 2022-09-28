//
//  Array+Data.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import Foundation

extension Array {
    
    func toData() -> Data? {
      return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
}
