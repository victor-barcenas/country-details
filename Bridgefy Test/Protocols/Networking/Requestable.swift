//
//  Requestable.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import Alamofire

protocol Requestable {
    
    var params: [String:AnyObject]? { get set }
    var headers: HTTPHeaders?  { get set }
    var url: String  { get set }
    var httpMethod: HTTPMethod  { get set }
    var encoding: ParameterEncoding  { get set }
    var networkManager: NetworkManager! { get set }
}


fileprivate struct RequestAssociatedKeys {
    static var parameters = "kParametersKey"
    static var headers = "kHeadersKey"
    static var url = "kUrlKey"
    static var method = "kMethodKey"
    static var encoding = "kEncodingKey"
}

//Setting default values
extension Requestable where Self: AnyObject {
    var params: Dictionary<String, AnyObject>? {
        get {
            let assocObj = objc_getAssociatedObject(self, &RequestAssociatedKeys.parameters)
            return assocObj as? Dictionary<String, AnyObject>
        }
        set {
            objc_setAssociatedObject(self, &RequestAssociatedKeys.parameters,
                                     newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var url: String {
        get {
            return objc_getAssociatedObject(self, &RequestAssociatedKeys.url) as? String ?? ""
        }
        set {
            objc_setAssociatedObject(self, &RequestAssociatedKeys.url,
                                     newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var headers: HTTPHeaders? {
        get {
            return objc_getAssociatedObject(self,
                                            &RequestAssociatedKeys.headers) as? HTTPHeaders
        }
        set {
            objc_setAssociatedObject(self, &RequestAssociatedKeys.headers,
                                     newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var httpMethod: HTTPMethod {
        get {
            return objc_getAssociatedObject(self,
                                            &RequestAssociatedKeys.method) as? HTTPMethod ?? .get
        }
        set {
            objc_setAssociatedObject(self, &RequestAssociatedKeys.method,
                                     newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var encoding: ParameterEncoding {
        get {
            return objc_getAssociatedObject(self,
                                            &RequestAssociatedKeys.encoding) as? ParameterEncoding ?? URLEncoding.default
        }
        set {
            objc_setAssociatedObject(self, &RequestAssociatedKeys.encoding,
                                     newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
