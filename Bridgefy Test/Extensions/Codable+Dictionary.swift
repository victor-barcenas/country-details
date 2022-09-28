//
//  Codable+Dictionary.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import Foundation

extension Encodable {
        
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    var data: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self.dictionary as Any,
                                                options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func from<T: Codable>(_ t: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: data)
    }

}
