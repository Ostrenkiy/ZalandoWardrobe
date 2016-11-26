//
//  UIImageExtension.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation

extension UIImage {
    func resizeTo(newSize: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func compressIn(bounds: CGSize) -> UIImage {
        var newSize = CGSize()
        if size.width > size.height {
            newSize.width = size.width
            let aspectRatio : CGFloat = newSize.width / size.width
            newSize.height = size.height * aspectRatio
        } else {
            newSize.height = size.height
            let aspectRatio : CGFloat = newSize.height / size.height
            newSize.width = size.width * aspectRatio        
        }
        
        return self.resizeTo(newSize: newSize)
    }
}
