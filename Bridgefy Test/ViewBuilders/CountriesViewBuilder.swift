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
    
    func build(with networkManager: NetworkManager) -> CountriesView {
        let countriesViewModel = CountriesViewModel(with: networkManager)
        countriesView = CountriesView(countriesViewModel)
        countriesView.setRootView()
        countriesView.setRightBarButton(
            "Group",
            selector: #selector(countriesView.groupAction(_:))
        )
        return countriesView
    }
    
}
