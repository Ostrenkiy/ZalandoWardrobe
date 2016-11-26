//
//  ClothingItem.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation

class ClothingItem {
    var imageURL : URL
    var isZalando : Bool
    
    init(imageURL: URL, isZalando: Bool) {
        self.imageURL = imageURL
        self.isZalando = isZalando
    }
}
