//
//  CountryDetailFetchable.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import CoreData

protocol CountryDetailFetchable: Persistentable {
    
    func fetch(_ countryName: String) -> Result<CountryDetail?, Error>
}

extension CountryDetailFetchable {
    
    func fetch(_ countryName: String) -> Result<CountryDetail?, Error> {
        let fetchRequest: NSFetchRequest<CountryDetailManaged> = CountryDetailManaged.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "name LIKE %@", countryName
        )
        do {
            let countryDetailManagedArray = try coreDataManager.managedObjectContext.fetch(fetchRequest)
            guard countryDetailManagedArray.count > 0 else {
                return .success(nil)
            }
            guard let countryDetailManaged = countryDetailManagedArray.first else {
                return .success(nil)
            }
            
            let flag: Flag = Flag.from(
                Flag.self,
                data: countryDetailManaged.flag ?? Data()) ?? Flag(png: "")
            let languages: Language = Language.from(
                Language.self,
                data: countryDetailManaged.languages ?? Data()) ?? Language(name: "")
            let currency: Currency = Currency.from(
                Currency.self,
                data: countryDetailManaged.currencies ?? Data()) ?? Currency(code: "", name: "", symbol: "")
            
            let countryDetail = CountryDetail(
                name: countryDetailManaged.name!,
                alpha2Code: countryDetailManaged.alpha2Code!,
                alpha3Code: countryDetailManaged.alpha3Code!,
                region: countryDetailManaged.region!,
                flags: flag,
                capital: countryDetailManaged.capital!,
                subregion: countryDetailManaged.subregion!,
                area: countryDetailManaged.area,
                latlng: countryDetailManaged.latlng?.toArray() ?? [],
                population: countryDetailManaged.population,
                languages: [languages],
                callingCodes: countryDetailManaged.callingCodes?.toArray() ?? [],
                borders: countryDetailManaged.borders?.toArray(),
                timezones: countryDetailManaged.timezones?.toArray() ?? [],
                currencies: [currency], isStored: true)
            return .success(countryDetail)
        } catch let error {
            return .failure(error)
        }
    }
}
