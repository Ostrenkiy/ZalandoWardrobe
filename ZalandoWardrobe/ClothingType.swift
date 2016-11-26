//
//  ClothingType.swift
//  ZalandoWardrobe
//
//  Created by Филипп Федяков on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation

class Clothing {
    private(set) var readableName:String
    private(set) var serverName:String

    init(_ readableName:String,_ serverName:String)
    {
        self.readableName = readableName
        self.serverName = serverName
    }
}


class Clothes {
    class func getAllClothes() -> Dictionary<String, [Clothing]> {
        var dic = Dictionary<String, [Clothing]>()
        dic["Shoes"] = [
            Clothing("Boots", "mens-shoes-boots"),
            Clothing("Flat shoes", "mens-shoes-flat-shoes"),
            Clothing("Sandals",  "mens-shoes-sandals"),
            Clothing("Outdoor", "mens-shoes-outdoor-shoes")]
        
        dic["Hats"] = [
            Clothing("Hats & Caps", "mens-hats-caps"),
            Clothing("Scarves", "mens-scarves")]
        
        dic["Clothing"] = [
            Clothing("Coats", "mens-clothing-coats"),
            Clothing("Chinos", "mens-clothing-trousers-chinos"),
            Clothing("Jackets",  "mens-clothing-jackets"),
            Clothing("Jumpers & Cardigans", "mens-clothing-jumpers-cardigans"),
            Clothing("Jeans", "mens-clothing-jeans"),
            Clothing("Shirts",  "mens-clothing-shirts"),
            Clothing("T-Shirts", "mens-clothing-t-shirts")]
        
        dic["Sport"] = [
            Clothing("Jackets & Gilets", "mens-sports-jackets-gilets"),
            Clothing("Jumpers & Sweatshirts","mens-sports-jumpers-sweatshirts"),
            Clothing("Shirts",  "mens-sports-shirts-tops"),
            Clothing("Shorts & Trousers", "mens-sports-shorts-trousers")]
        
        return dic
    }
}
