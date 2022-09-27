//
//  Data+Array.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import Foundation

extension Data {
    func toArray<T>() -> [T]? {
        return (try? JSONSerialization.jsonObject(with: self, options: [])) as? [T]
    }
}
