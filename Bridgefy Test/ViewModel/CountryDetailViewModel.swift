//
//  CountryDetailViewModel.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 26/09/22.
//

import Foundation

final class CountryDetailViewModel: CountryDetailQueryable {
    
    var networkManager: NetworkManager!
    
    init(with networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

}
