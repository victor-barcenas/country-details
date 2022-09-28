//
//  CountryDetailViewModel.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 26/09/22.
//

import CoreData

final class CountryDetailViewModel: CountryDetailQueryable,
                                    CountryDetailStorable,
                                    CountryDetailFetchable,
                                    CountryDetailDeleteable {
    
    var coreDataManager: CoreDataManager!
    var entityDescription: NSEntityDescription?
    var networkManager: NetworkManager!
    
    init(with networkManager: NetworkManager, coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
        entityDescription = NSEntityDescription.entity(forEntityName: "CountryDetailManaged",
                                                       in: coreDataManager.managedObjectContext)
    }

}
