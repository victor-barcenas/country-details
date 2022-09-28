//
//  CountriesVIewBuilder.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import UIKit

final class CountriesViewBuilder {
    var countriesView: CountriesView!
    var contentView: UIView!
    
    func build(with networkManager: NetworkManager,
               coreDataManager: CoreDataManager) -> CountriesView {
        let countriesViewModel = CountriesViewModel(with: networkManager,
                                                    coredataManager: coreDataManager)
        countriesView = CountriesView(countriesViewModel)
        countriesView.setRootView()
        countriesView.setRightBarButton(
            "Group",
            selector: #selector(countriesView.groupAction(_:))
        )
        return countriesView
    }
    
}
