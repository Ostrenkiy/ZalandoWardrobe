//
//  ItemSet.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation
import SwiftyJSON

class ItemSet {
    var items: [ClothingItem] = []
    
    init(items: [ClothingItem]) {
        self.items = items
    }
    
    init?(json: JSON) {
        guard let arr = json.array else { return nil }
        for itemJson in arr {
            if let item = ClothingItem(json: itemJson) {
                items += [item]
            }
        }
    }
}
