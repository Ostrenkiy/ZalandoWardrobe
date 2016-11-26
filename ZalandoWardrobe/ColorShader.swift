//
//  ColorShader.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import UIKit
import EDColor

class ColorShades: NSObject {
    let mainColors : [UIColor] = IttenColors
    var shades = [[UIColor]]()
    
    override init() {
        super.init()
        var lighter : [UIColor] = []
        for color in mainColors {
            lighter += [get(lighter: true, color: color)]
        }
        shades.append(lighter)
        
        var darker : [UIColor] = []
        for color in mainColors {
            darker += [get(lighter: false, color: color)]
        }
        shades.append(darker)
    }
    
    func getAllColors() -> [UIColor] {
        var res : [UIColor] = []
        for i in 0 ..< mainColors.count {
            res += [shades[0][i]] + [mainColors[i]] + [shades[1][i]]
        }
        return res
    }
    
    func getMainColor(color: UIColor) -> UIColor? {
        for i in 0 ..< mainColors.count {
            if color == shades[0][i] || color == shades[1][i] || color == mainColors[i] {
                return mainColors[i]
            }
        }
        return nil
    }
    
    private func get(lighter: Bool, color: UIColor) -> UIColor {
        var h,s,l, a : CGFloat
        h = 0
        s = 0
        l = 0
        a = 0
        let hslColor = color.getHue(&h, saturation: &s, brightness: &l, alpha: &a)
        
        if lighter {
            l = l*1.6
        } else {
            l = l*0.6
        }
        
        return UIColor(hue: h, saturation: s, lightness: l, alpha: a)
    }
    
    var colorSetAndAdditional : NSSet {
        return NSSet(array: getAllColors() + DefaultColors)
    }
}

let IttenColors : [UIColor] = [
    UIColor(red: 249/255, green: 201/255, blue: 10/255, alpha: 1), //Yellow
    UIColor(red: 245/255, green: 144/255, blue: 9/255, alpha: 1), //Yellow - Orange
    UIColor(red: 241/255, green: 90/255, blue: 8/255, alpha: 1), //Orange
    UIColor(red: 238/255, green: 35/255, blue: 11/255, alpha: 1), //Red - Orange
    UIColor(red: 209/255, green: 0, blue: 16/255, alpha: 1), //Red
    UIColor(red: 118/255, green: 0, blue: 90/255, alpha: 1), //Red - Purple
    UIColor(red: 65/255, green: 0, blue: 148/255, alpha: 1), //Purple
    UIColor(red: 15/255, green: 35/255, blue: 166/255, alpha: 1), // Blue - Purple
    UIColor(red: 14/255, green: 72/255, blue: 190/255, alpha: 1), //Blue
    UIColor(red: 18/255, green: 123/255, blue: 175/255, alpha: 1), //Blue - Green
    UIColor(red: 63/255, green: 132/255, blue: 13/255, alpha: 1), //Green
    UIColor(red: 144/255, green: 168/255, blue: 13/255, alpha: 1) // Yellow - Green
]

let DefaultColors : [UIColor] = [
    UIColor(red: 0, green: 0, blue: 0, alpha: 1), //Black
    UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1), //Gray
    UIColor(red: 1, green: 1, blue: 1, alpha: 1) //White
]
