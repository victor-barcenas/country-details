//
//  UIImageView+Download.swift
//  Bridgefy Test
//
//  Created by Victor Alfonso Barcenas Monreal on 25/09/22.
//

import UIKit
import Alamofire

extension UIImageView {
    
    static let cache = NSCache<NSString, UIImage>()
    
    func load(from url: String, completion: @escaping ((UIImage?) -> Void)) {
        var imageKey: NSString!
        
        if let imageId = url.slice(from: "https://", to: "?") {
            imageKey = NSString(string: imageId)
            if let cachedImage = UIImageView.cache.object(forKey: imageKey) {
                completion(cachedImage)
                return
            }
        }
        AF.request(url, method: .get).response { response in
           switch response.result {
            case .success(let responseData):
               guard let imageData = responseData else {
                   print("Cannot parse image data received")
                   completion(nil)
                   return
               }
               guard let image = UIImage(data: imageData) else {
                   print("Cannot init image with data received")
                   completion(nil)
                   return
               }
               self.image = image
               if imageKey != nil {
                   DispatchQueue.main.async {
                       UIImageView.cache.setObject(image, forKey: imageKey)
                   }
               }
               completion(image)
            case .failure(let error):
                print("Image download error: ", error)
               completion(nil)
            }
        }
    }
    
    static func removeFromCache(_ url: String) {
        var imageKey: NSString!
        
        if let imageId = url.slice(from: "https://", to: "?") {
            imageKey = NSString(string: imageId)
            if let _ = UIImageView.cache.object(forKey: imageKey) {
                UIImageView.cache.removeObject(forKey: imageKey)
                return
            }
        }
    }
}
