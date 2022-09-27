//
//  CountryDetailQueryable.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 26/09/22.
//

import Alamofire

typealias CountryDetailQueryableResult =  Result<[CountryDetail], Error>
typealias CountryDetailQueryableHandler = (CountryDetailQueryableResult) -> Void

protocol CountryDetailQueryable: Requestable {
    func getCountryDetail(_ name: String,
                          _ completion: @escaping CountryDetailQueryableHandler)
}

extension CountryDetailQueryable where Self: AnyObject  {
    
    func getCountryDetail(_ name: String,
                          _ completion: @escaping CountryDetailQueryableHandler) {
        let decodedName = name
        let nameEncoded = decodedName.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        url = Endpoints.Country.detail + (nameEncoded ?? "")
        httpMethod = .get
        encoding = URLEncoding.default
        networkManager.execute(request: self) { (response: CountryDetailQueryableResult) in
            switch response {
            case .success(let countryResponse):
                completion(.success(countryResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

