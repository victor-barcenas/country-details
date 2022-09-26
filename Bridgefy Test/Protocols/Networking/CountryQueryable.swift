//
//  CountryQueryable.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import Alamofire

typealias CountriesQueryableResult =  Result<[Country], Error>
typealias CountriesQueryableHandler = (CountriesQueryableResult) -> Void

protocol CountriesQueryable: Requestable {
    func getCountries(_ completion: @escaping CountriesQueryableHandler)
}

extension CountriesQueryable where Self: AnyObject  {
    
    func getCountries(_ completion: @escaping CountriesQueryableHandler) {
        url = Endpoints.Country.list
        httpMethod = .get
        encoding = URLEncoding.default
        networkManager.execute(request: self) { (response: CountriesQueryableResult) in
            switch response {
            case .success(let countryResponse):
                completion(.success(countryResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
