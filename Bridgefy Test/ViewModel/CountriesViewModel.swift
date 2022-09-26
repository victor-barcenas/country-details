//
//  CountriesViewModel.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import Foundation

final class CountriesViewModel: CountriesQueryable {
    var networkManager: NetworkManager!
    
    private var regions: [String] = []
    private var countriesByRegion: [String: [Country]] = [:]
    private var countriesList: [Country] = []
    private lazy var countriesFiltered: [Country] = []
    private var isSearchActive: Bool = false
    
    var areCountriesGrouped = false
    
    var sectionsCount: Int {
        return areCountriesGrouped ? regions.count : 1
    }
    
    init(with networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func set(countries: [Country]) {
        countriesList = countries
        _ = countries.compactMap { country in
            if countriesByRegion[country.region] == nil {
                countriesByRegion[country.region] = []
            } else {
                countriesByRegion[country.region]?.append(country)
            }
        }
        regions = countriesByRegion.keys.sorted()
    }
    
    func group() {
        areCountriesGrouped = !areCountriesGrouped
    }
    
    func numberOfRows(at section: Int) -> Int {
        guard !isSearchActive else {
            return countriesFiltered.count
        }
        guard areCountriesGrouped else {
            return countriesList.count
        }
        let region = regions[section]
        return countriesByRegion[region]?.count ?? 0
    }
    
    func country(at indexPath: IndexPath) -> Country? {
        guard countriesFiltered.count <= 0 else {
            return countriesFiltered[indexPath.row]
        }
        guard areCountriesGrouped else {
            return countriesList[indexPath.row]
        }
        let region = regions[indexPath.section]
        return countriesByRegion[region]?[indexPath.row]
    }
    
    func titleFor(_ section: Int) -> String {
        return regions[section]
    }
    
    func search(_ text: String) {
        guard text.count > 0 else {
            countriesFiltered = []
            isSearchActive = false
            return
        }
        isSearchActive = true
        countriesFiltered = countriesList.filter { country in
            let name = country.name.lowercased()
            return name.contains(text.lowercased())
        }
    }
}
