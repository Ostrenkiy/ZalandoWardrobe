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
}
