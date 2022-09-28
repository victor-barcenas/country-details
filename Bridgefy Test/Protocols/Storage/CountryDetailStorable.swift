//
//  CountryDetailStorable.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import Foundation


protocol CountryDetailStorable: Persistentable {
    func store(countryDetail: CountryDetail) throws -> Error?
}

extension CountryDetailStorable {
    func store(countryDetail: CountryDetail) throws -> Error? {
        guard let entity = entityDescription else { return nil}
        let countryDetailManaged = CountryDetailManaged(entity: entity,
                             insertInto: coreDataManager.managedObjectContext)
        
        countryDetailManaged.borders = countryDetail.borders?.toData()
        countryDetailManaged.alpha3Code = countryDetail.alpha3Code
        countryDetailManaged.alpha2Code = countryDetail.alpha2Code
        countryDetailManaged.area = countryDetail.area ?? 0.0
        countryDetailManaged.timezones = countryDetail.timezones.toData()
        countryDetailManaged.callingCodes = countryDetail.callingCodes.toData()
        countryDetailManaged.name = countryDetail.name
        countryDetailManaged.capital = countryDetail.capital
        
        let currencyData = countryDetail.currencies?.first?.data
        countryDetailManaged.currencies = currencyData
        
        countryDetailManaged.flag = countryDetail.flags.data
        
        let languageData = countryDetail.languages.first?.data
        countryDetailManaged.languages = languageData
        
        countryDetailManaged.latlng = countryDetail.latlng.toData()
        countryDetailManaged.population = countryDetail.population
        countryDetailManaged.region = countryDetail.region
        countryDetailManaged.subregion = countryDetail.subregion

        do {
            try coreDataManager.managedObjectContext.save()
        } catch let error as NSError {
            return error
        }
        return nil
    }
}
