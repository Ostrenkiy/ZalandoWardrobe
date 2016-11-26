//
//  ClothingItem.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation
import SwiftyJSON

class ClothingItem {
    var imageURL : URL
    var imageHash : String
    var isZalando : Bool
    var zalandoURL : URL?
    var category: String
    var colors : [UIColor] = []
    
    init(imageURL: URL, isZalando: Bool) {
        self.imageURL = imageURL
        self.isZalando = isZalando
        self.imageHash = ""
        self.zalandoURL = nil
        self.category = "mens-sports-shoes"
    }
    
    init?(json: JSON) {
        self.imageURL = URL(string: json["media"]["url"].stringValue)!
        self.isZalando = json["is_zalando"].boolValue
        if let zalandoURLString = json["zalando_url"].string {
            self.zalandoURL = URL(string: zalandoURLString)
        } else {
            self.zalandoURL = nil
        }
        self.imageHash = json["media"]["hash"].stringValue
        for hexString in json["media"].arrayValue.map({$0.stringValue}) {
            colors += [UIColor(hexString: hexString)]
        }
        self.category = json["category"].stringValue
    }
    
}
