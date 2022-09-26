//
//  TabViewItem.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 24/09/22.
//

import Foundation
import UIKit

enum TabViewItem {
    case countries
    case ble
    
    var buttonItem: UITabBarItem {
        let image = self.image.withRenderingMode(.alwaysOriginal)
        return UITabBarItem(title: self.title, image: image, tag: 0)
    }
    
    var title: String {
        switch self {
        case .countries:
            return "Countries"
        case .ble:
            return "BLE"
        }
    }
    
    var image: UIImage {
        switch self {
        case .countries:
            return UIImage(named: "CountriesOff") ?? UIImage()
        case .ble:
            return UIImage(named: "BLEOff") ?? UIImage()
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .countries:
            return UIImage(named: "CountriesOn") ?? UIImage()
        case .ble:
            return UIImage(named: "BLEOn") ?? UIImage()
        }
    }
}
