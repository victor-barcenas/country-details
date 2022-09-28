//
//  TabView.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 24/09/22.
//

import UIKit

final class TabViewBuilder {
    
    func build() -> TabView {
        let tabView = TabView()
        tabView.tabBar.tintColor = .baseOrange
        tabView.tabBar.unselectedItemTintColor = .gray
        tabView.tabBar.backgroundColor = UIColor(red: 0.979, green: 0.971,
                                                 blue: 0.971, alpha: 1)
        let networkManager = NetworkManager()
        let coreDataManager = CoreDataManager(modelName: "Bridgefy")
        
        let countriesView = CountriesViewBuilder().build(with: networkManager,
                                                         coreDataManager: coreDataManager)
        countriesView.tabBarItem = TabViewItem.countries.buttonItem
        countriesView.tabBarItem.selectedImage = TabViewItem.countries.selectedImage
        countriesView.title = "Countries"
        
        let countriesNavController = UINavigationController(rootViewController: countriesView)
        countriesNavController.navigationBar.prefersLargeTitles = true
        setNavigationBarAppereance(countriesNavController)
        
        let bleView = BLEView()
        bleView.setRootView()
        bleView.tabBarItem = TabViewItem.ble.buttonItem
        bleView.tabBarItem.selectedImage = TabViewItem.ble.selectedImage
        bleView.title = "BLE"
        
        let bleNavController = UINavigationController(rootViewController: bleView)
        bleNavController.navigationBar.prefersLargeTitles = true
        setNavigationBarAppereance(bleNavController)
        
        tabView.viewControllers = [countriesNavController, bleNavController]
        
        return tabView
    }
    
    private func setNavigationBarAppereance(_ navController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        navController.navigationBar.tintColor = .baseOrange
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.compactAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
    }
}
