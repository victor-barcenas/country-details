//
//  NetworkManager.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import Alamofire

typealias ResponseHandler<T: Decodable, E: Error> = (Result<T, E>) -> Void

class NetworkManager {
    
    private var sessionManager: Alamofire.Session
    
    init() {
        sessionManager = Session()
        sessionManager.session.configuration.timeoutIntervalForRequest = 30
        sessionManager.session.configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    }
    
    func execute<ApiRequest: Requestable, ResponseType: Codable, E: Error>(request: ApiRequest,
                                                                 completion: @escaping ResponseHandler<ResponseType, E>) {
        print("⚠️<---- REQUEST -----")
        print("  ▫️ URL: " + request.url )
        print("  ▫️ METHOD: " + request.httpMethod.rawValue)
        if request.params != nil {
            print("  ▫️ BODY: ")
            print(request.params as Any)
            print("  ▫️ BODY SIZE: ")
            print(try! JSONSerialization.data(withJSONObject: request.params as Any, options: .prettyPrinted) as Any)
        }
        print("  ▫️ ENCODING: " + String.init(describing: request.encoding.self))
        print("  ▫️ HEADERS: ")
        print(request.headers as Any)
        print("----- REQUEST ---->⚠️")
        sessionManager.request(
            request.url,
            method: request.httpMethod,
            parameters: request.params,
            encoding: request.encoding,
            headers: request.headers)
            .responseData(completionHandler: { response in
                let decoder = JSONDecoder()
                guard let statusCode = response.response?.statusCode, (200..<300).contains(statusCode) else {
                    let error = NSError(domain: "",
                                        code: response.response?.statusCode ?? -99)
                    completion(.failure(error as! E))
                    print()
                    print("❌<---- RESPONSE -----")
                    print(response.response?.url?.absoluteString as Any)
                    print(response.response?.statusCode as Any)
                    print("----- RESPONSE ---->❌")
                    return
                }
                if let data = response.data,
                    let apiResponse = try? decoder.decode(ResponseType.self, from: data) {
                    completion(.success(apiResponse))
                    print()
                    print("✅<---- RESPONSE -----")
                    print(apiResponse)
                    print("----- RESPONSE ---->✅")
                } else {
                    print()
                    print("❌<---- RESPONSE -----")
                    let str = String(decoding: response.data ?? Data(), as: UTF8.self)
                    print("Unable to parse received data: \(str)")
                    print("----- RESPONSE ---->❌")
                }
            })
    }
}
