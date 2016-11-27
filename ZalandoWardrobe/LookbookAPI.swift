//
//  LookbookAPI.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 27.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LookbookAPI {
    
    func retrieve(success successHandler: @escaping ([ItemSet]) -> Void, error errorHandler : @escaping (String) -> Void) {
        Alamofire.request("http://delivery-service-api.appspot.com/v1/users/ahZlfmRlbGl2ZXJ5LXNlcnZpY2UtYXBpchELEgRVc2VyGICAgICAgIAKDA/lookbook/", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseSwiftyJSON({
            response in
            
            if let e = response.result.error as? NSError {
                errorHandler("RETRIEVE lookbooks: error \(e.domain) \(e.code): \(e.localizedDescription)")
                return
            }
            
            if response.response?.statusCode != 200 {
                errorHandler("RETRIEVE lookbooks: bad response status code \(response.response?.statusCode)")
                return
            }
            
            let json : JSON = response.result.value!
            var items = [ItemSet]()
            for setJSON in json.arrayValue {
                if let item = ItemSet(json: setJSON) {
                    items += [item]
                } 
            }
            print(json)
            successHandler(items)
        })  
    }

    
}
