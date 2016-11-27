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
    var imageURL : URL? = nil
    var image: UIImage? = nil
    var imageHash : String
    var hash: String
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
        self.hash = "qwerqwerqwre"
    }
    
    init?(json: JSON, image: UIImage? = nil) {
        
        if let i = image {
            self.image = i
        }
        self.hash = json["hash"].stringValue
//        self.imageURL = URL(string: json["media"]["url"].stringValue)!
        self.isZalando = json["is_zalando"].boolValue
        if let zalandoURLString = json["zalando_url"].string {
            self.zalandoURL = URL(string: zalandoURLString)
        } else {
            self.zalandoURL = nil
        }
//        self.imageHash = json["media"]["hash"].stringValue
//        for hexString in json["media"].arrayValue.map({$0.stringValue}) {
//            colors += [UIColor(hexString: hexString)]
//        }
        if json["media"]["status"] == "pending" {
            self.imageHash = json["media"]["hash"].stringValue
        } else {
            if let imageUrlString = json["media"]["url"].string {
                self.imageURL = URL(string: imageUrlString)!        
            } else {
                if let imageUrlString = json["media_url"].string {
                    self.imageURL = URL(string: imageUrlString)!
                } 
            }
            self.imageHash = json["media"]["hash"].stringValue
            for hexString in json["media"].arrayValue.map({$0.stringValue}) {
                colors += [UIColor(hexString: hexString)]
            }

        }
        self.category = json["category"].stringValue
    }
    
}
