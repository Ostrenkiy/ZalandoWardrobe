//
//  NewClothingItem.swift
//  ZalandoWardrobe
//
//  Created by Филипп Федяков on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation

struct NewClothingItem {
    var colors:[UIColor]
    var image:UIImage
    var clothingType:ClothingType
    
    init(colors:[UIColor], image:UIImage, clothingType:ClothingType) {
        self.colors = colors
        self.clothingType = clothingType
        self.image = image
    }
}
