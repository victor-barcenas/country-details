//
//  Persistentable.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 27/09/22.
//

import CoreData

protocol Persistentable {
    var coreDataManager: CoreDataManager { get set }
    var entityDescription: NSEntityDescription? { get set }
}
