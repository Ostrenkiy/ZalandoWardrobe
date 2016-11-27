//
//  ClothesAPI.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ClothesAPI {
    func retrieve(success successHandler: @escaping ([ClothingItem]) -> Void, error errorHandler : @escaping (String) -> Void) {
        Alamofire.request("http://delivery-service-api.appspot.com/v1/users/ahZlfmRlbGl2ZXJ5LXNlcnZpY2UtYXBpchELEgRVc2VyGICAgICAgIAKDA/cloths/", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseSwiftyJSON({
            response in
            
            if let e = response.result.error as? NSError {
                errorHandler("RETRIEVE clothes: error \(e.domain) \(e.code): \(e.localizedDescription)")
                return
            }
            
            if response.response?.statusCode != 200 && response.response?.statusCode != 202 {
                errorHandler("RETRIEVE clothes: bad response status code \(response.response?.statusCode)")
                return
            }
            
            let json : JSON = response.result.value!
            var items = [ClothingItem]()
            for itemJSON in json.arrayValue {
                if let item = ClothingItem(json: itemJSON) {
                    items += [item]
                } 
            }
            print(json)
            print(items)
            successHandler(items)
        })  
    }
    
    func create(hash: String, category: String, colors: [UIColor], image: UIImage? = nil, success successHandler: @escaping (ClothingItem) -> Void, error errorHandler : @escaping (String) -> Void) {
        let params : Parameters = [
            "media_key": hash,
            "is_zalando": false,
            "category_name": category,
            "colors" : colors.flatMap({"#\($0.hexString()!)"})
        ]
        
        Alamofire.request("http://delivery-service-api.appspot.com/v1/users/ahZlfmRlbGl2ZXJ5LXNlcnZpY2UtYXBpchELEgRVc2VyGICAgICAgIAKDA/cloths/", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseSwiftyJSON({
            response in
            
            if let e = response.result.error as? NSError {
                errorHandler("CREATE clothes: error \(e.domain) \(e.code): \(e.localizedDescription)")
                return
            }
            
            if response.response?.statusCode != 201 {
                errorHandler("CREATE clothes: bad response status code \(response.response?.statusCode)")
                return
            }
            
            let json : JSON = response.result.value!
            print(json)

            if let item = ClothingItem(json: json, image: image) {
                successHandler(item)
            } else {
                errorHandler("Could not do anything")
            }
        })  
    }
    
    func delete(item: ClothingItem, success successHandler: @escaping (Void) -> Void, error errorHandler : @escaping (String) -> Void) {
        let hash = item.hash
        Alamofire.request("http://delivery-service-api.appspot.com/v1/cloths/\(hash)/", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseData(completionHandler: {
            response in
            
            if let e = response.result.error as? NSError {
                errorHandler("DELETE clothes: error \(e.domain) \(e.code): \(e.localizedDescription)")
                return
            }
            
            if response.response?.statusCode != 204 {
                errorHandler("DELETE clothes: bad response status code \(response.response?.statusCode)")
            } else {
                successHandler()
            }
        })  

    }
}
