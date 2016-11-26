//
//  ClothingTypes.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation

protocol NamedReadable {
    var readableName: String { get }
}

protocol EnumListable {
    static var allRawValues : [String] { get }
}

class ClothingType {
    enum mensShoes : String, NamedReadable, EnumListable {
        case boots = "mens-shoes-boots"
        case flatShoes = "mens-shoes-flat-shoes"
        case sandals = "mens-shoes-sandals"
        case outdoor = "mens-shoes-outdoor-shoes"
        
        var readableName: String {
            switch self {
            case .boots :
                return "Boots"
            case .flatShoes:
                return "Flat shoes"
            case .sandals:
                return "Sandals"
            case .outdoor:
                return "Outdoor"
            }
        }
        
        static var allRawValues: [String] {
            return [mensShoes.boots.rawValue, mensShoes.flatShoes.rawValue, mensShoes.sandals.rawValue, mensShoes.outdoor.rawValue]
        }
    }    
    enum bagsAccessories : String, NamedReadable, EnumListable {
        case hatsCaps = "mens-hats-caps"
        case scarves = "mens-scarves"
        
        var readableName: String {
            switch self {
            case .hatsCaps:
                return "Hats & Caps"
            case .scarves:
                return "Scarves"
            }
        }
        
        static var allRawValues: [String] {
            return [bagsAccessories.hatsCaps.rawValue, bagsAccessories.scarves.rawValue]
        }
    }
    
    enum mensClothing: String, NamedReadable, EnumListable {
        case coats = "mens-clothing-coats"
        case chinos = "mens-clothing-trousers-chinos"
        case jackets = "mens-clothing-jackets"
        case jeans = "mens-clothing-jeans"
        case jumpersCardigans = "mens-clothing-jumpers-cardigans"
        case shirts = "mens-clothing-shirts"
        case tShirts = "mens-clothing-t-shirts"
        
        var readableName: String {
            switch self {
            case .coats:
                return "Coats"
            case .chinos:
                return "Chinos"
            case .jackets:
                return "Jackets"
            case .jeans:
                return "Jeans"
            case .jumpersCardigans:
                return "Jumpers & Cardigans"
            case .shirts:
                return "Shirts"
            case .tShirts:
                return "T-Shirts"
            }
        }
        
        static var allRawValues: [String] {
            return [mensClothing.coats.rawValue, mensClothing.chinos.rawValue, mensClothing.jackets.rawValue, mensClothing.jeans.rawValue, mensClothing.jumpersCardigans.rawValue, mensClothing.shirts.rawValue, mensClothing.tShirts.rawValue]
        }
    }
    
    enum sports: String, NamedReadable, EnumListable {
        case shoes = "mens-sports-shoes"
        
        enum clothing: String, NamedReadable, EnumListable {
            case jacketsGilets = "mens-sports-jackets-gilets"
            case jumpersSweatshirts = "mens-sports-jumpers-sweatshirts"
            case shirts = "mens-sports-shirts-tops"
            case shortsTrousers = "mens-sports-shorts-trousers"
            
            var readableName: String {
                switch self {
                case .jacketsGilets:
                    return "Jackets & Gilets"
                case .jumpersSweatshirts:
                    return "Jumpers & Sweatshirts"
                case .shirts:
                    return "Shirts"
                case .shortsTrousers:
                    return "Shorts & Trousers"
                }
            }
            
            static var allRawValues: [String] {
                return [sports.clothing.jacketsGilets.rawValue, sports.clothing.jumpersSweatshirts.rawValue, sports.clothing.shirts.rawValue, sports.clothing.shortsTrousers.rawValue]
            }
        }
        
        var readableName: String {
            switch self {
            case .shoes:
                return "Sport Shoes"
            }
        }
        
        static var allRawValues: [String] {
            return [sports.shoes.rawValue] + sports.clothing.allRawValues
        }
    }
    
}

