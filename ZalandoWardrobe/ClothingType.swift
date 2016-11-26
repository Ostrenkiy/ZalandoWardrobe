//
//  ClothingType.swift
//  ZalandoWardrobe
//
//  Created by Филипп Федяков on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation

class ClothingType {
    private(set) var readableName:String
    private(set) var serverName:String

    init(_ readableName:String,_ serverName:String)
    {
        self.readableName = readableName
        self.serverName = serverName
    }
}


class Clothes {
    
    class func getAllClothes() -> Dictionary<String, [ClothingType]> {
        var dic = Dictionary<String, [ClothingType]>()
        dic["Shoes"] = [
            ClothingType("Boots", "mens-shoes-boots"),
            ClothingType("Flat shoes", "mens-shoes-flat-shoes"),
            ClothingType("Sandals",  "mens-shoes-sandals"),
            ClothingType("Outdoor", "mens-shoes-outdoor-shoes")]
        
        dic["Hats"] = [
            ClothingType("Hats & Caps", "mens-hats-caps"),
            ClothingType("Scarves", "mens-scarves")]
        
        dic["ClothingType"] = [
            ClothingType("Coats", "mens-clothing-coats"),
            ClothingType("Chinos", "mens-clothing-trousers-chinos"),
            ClothingType("Jackets",  "mens-clothing-jackets"),
            ClothingType("Jumpers & Cardigans", "mens-clothing-jumpers-cardigans"),
            ClothingType("Jeans", "mens-clothing-jeans"),
            ClothingType("Shirts",  "mens-clothing-shirts"),
            ClothingType("T-Shirts", "mens-clothing-t-shirts")]
        
        dic["Sport"] = [
            ClothingType("Jackets & Gilets", "mens-sports-jackets-gilets"),
            ClothingType("Jumpers & Sweatshirts","mens-sports-jumpers-sweatshirts"),
            ClothingType("Shirts",  "mens-sports-shirts-tops"),
            ClothingType("Shorts & Trousers", "mens-sports-shorts-trousers")]
        
        return dic
    }
}
