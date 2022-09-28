//
//  CountryDetailDeleteable.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import CoreData

protocol CountryDetailDeleteable: Persistentable {
    
    func delete(by countryName: String) -> Result<Bool, Error>
}

extension CountryDetailDeleteable {
    
    func delete(by countryName: String) -> Result<Bool, Error> {
        let fetchRequest: NSFetchRequest<CountryDetailManaged> = CountryDetailManaged.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "name LIKE %@", countryName
        )
        do {
            let results = try coreDataManager.managedObjectContext.fetch(fetchRequest)
            for result in results {
                coreDataManager.managedObjectContext.delete(result)
            }
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }
}







