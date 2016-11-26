//
//  ColorRecognizer.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation

import UIKit

class ColorRecognizer: NSObject {
    
    let pixelData : CFData
    let data : UnsafePointer<UInt8>
    let image : UIImage
    let cs = ColorShades()
    
    init(image : UIImage) {
        //super.init()
        self.image = image
        pixelData = image.cgImage!.dataProvider!.data!
        data = CFDataGetBytePtr(pixelData)
    }
    
    func getColors() -> [UIColor] {
        var res : [UIColor] = []
        
        //GPUImageAverageLuminanceThresholdFilter
        let resImage = image.resize(size: CGSize(width: 40, height: 40))
        res = getCollectionColors(image: resImage)
        return res
    }
    
    private func similarTo(color: UIColor) -> UIColor {
        return color.mostSimilarColor(in: cs.colorsSet as Set<NSObject>)
    }
    
    
    private func getCollectionColors(image : UIImage) -> [UIColor] {
        var colors = [UIColor]()
        var countedColors : [UIColor : Int] = [:]
        
        var totalCount = 0
        
        for  i in 0 ..< Int(image.size.width) {
            for j in 0 ..< Int(image.size.height) {
                let curColorRGBA = image.color(at: CGPoint(x: i, y: j))!
//                let curColorRGBA = image.getPixelColorAtLocation(point: CGPoint(x: i, y: j))!//self.getColorOfPixel(Int(i), y: Int(j))
                if curColorRGBA.getAlpha() != 1 {
                    continue
                }
                //println("detected color red: \(curColorRGBA.redComponent()) green: \(curColorRGBA.greenComponent()) blue: \(curColorRGBA.blueComponent())")
                let collectionColor = similarTo(color: curColorRGBA)
                //if find(DefaultColors, collectionColor) != nil { continue }
                let count : Int = countedColors[collectionColor] ?? 0
                countedColors[collectionColor] = count + 1
                totalCount += 1
            }
        } 
        
        for (color, count) in countedColors {
            if Double(count)/Double(totalCount) > 0.05 {
                colors += [color]
            }
        }
        
        return colors
    }
    
    private func getColorOfPixel(x : Int, y : Int) -> UIColor {
        let pixelInfo : Int = ((Int(image.size.width) * y) + x) * 4
        let red : UInt8 = data[pixelInfo]
        let green : UInt8 = data[(pixelInfo + 1)]
        let blue : UInt8 = data[(pixelInfo + 2)]
        let alpha : UInt8 = data[(pixelInfo + 3)]
        
        print("detected color red: \(red) green: \(green) blue: \(blue)")
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/255.0)
    }
    
}

extension UIImage { 
    public func resize(size:CGSize) -> UIImage {
        let newSize:CGSize = size
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIColor {
    public func getAlpha() -> CGFloat {
        let alpha = self.cgColor.alpha
        return alpha
    }
}

private extension UIImage {
    func createARGBBitmapContext(inImage: CGImage) -> CGContext {
        
        //Get image width, height
        let pixelsWide = inImage.width
        let pixelsHigh = inImage.height
        
        // Declare the number of bytes per row. Each pixel in the bitmap in this
        // example is represented by 4 bytes; 8 bits each of red, green, blue, and
        // alpha.
        let bitmapBytesPerRow = Int(pixelsWide) * 4
        let bitmapByteCount = bitmapBytesPerRow * Int(pixelsHigh)
        
        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData = malloc(bitmapByteCount)
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
        // per component. Regardless of what the source image format is
        // (CMYK, Grayscale, and so on) it will be converted over to the format
        // specified here by CGBitmapContextCreate.
        let context = CGContext(data: bitmapData, width: pixelsWide, height: pixelsHigh, bitsPerComponent: 8, bytesPerRow: bitmapBytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        return context!
    }
    
    func sanitizePoint(point:CGPoint) {
        let inImage:CGImage = self.cgImage!
        let pixelsWide = inImage.width
        let pixelsHigh = inImage.height
        let rect = CGRect(x:0, y:0, width:Int(pixelsWide), height:Int(pixelsHigh))
        
        precondition(rect.contains(point), "CGPoint passed is not inside the rect of image.It will give wrong pixel and may crash.")
    }
}


// Internal functions exposed.Can be public.

extension  UIImage {
    typealias RawColorType = (newRedColor:UInt8, newgreenColor:UInt8, newblueColor:UInt8,  newalphaValue:UInt8)
    
    /*
     Get pixel color for a pixel in the image.
     */
    func getPixelColorAtLocation(point:CGPoint)->UIColor? {
        self.sanitizePoint(point: point)
        // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
        let inImage:CGImage = self.cgImage!
        let context = self.createARGBBitmapContext(inImage: inImage)
        
        let pixelsWide = inImage.width
        let pixelsHigh = inImage.height
        let rect = CGRect(x:0, y:0, width:Int(pixelsWide), height:Int(pixelsHigh))
        
        //Clear the context
        context.clear(rect)
        
        // Draw the image to the bitmap context. Once we draw, the memory
        // allocated for the context for rendering will then contain the
        // raw image data in the specified color space.
//        CGContextDrawImage(context, rect, inImage)
        context.draw(inImage, in: rect)

        // Now we can get a pointer to the image data associated with the bitmap
        // context.
        let provider = self.cgImage!.dataProvider
        let providerData = provider!.data
        guard let dataType = CFDataGetBytePtr(providerData) else {
            return nil
        }
        
        let offset = 4*((Int(pixelsWide) * Int(point.y)) + Int(point.x))
        let alphaValue = dataType[offset]
        let redColor = dataType[offset+1]
        let greenColor = dataType[offset+2]
        let blueColor = dataType[offset+3]
        
        let redFloat = CGFloat(redColor)/255.0
        let greenFloat = CGFloat(greenColor)/255.0
        let blueFloat = CGFloat(blueColor)/255.0
        let alphaFloat = CGFloat(alphaValue)/255.0
        
        return UIColor(red: redFloat, green: greenFloat, blue: blueFloat, alpha: alphaFloat)
        
        // When finished, release the context
        // Free image data memory for the context
    }
    
    
    
    // Defining the closure.
    typealias ModifyPixelsClosure = (_ point:CGPoint, _ redColor:UInt8, _ greenColor:UInt8, _ blueColor:UInt8, _ alphaValue:UInt8)->(newRedColor:UInt8, newgreenColor:UInt8, newblueColor:UInt8,  newalphaValue:UInt8)
    
    
    // Provide closure which will return new color value for pixel using any condition you want inside the closure.
    
//    func applyOnPixels(closure:ModifyPixelsClosure) -> UIImage? {
//        let inImage:CGImage = self.cgImage!
//        let context = self.createARGBBitmapContext(inImage: inImage)
//        let pixelsWide = inImage.width
//        let pixelsHigh = inImage.height
//        let rect = CGRect(x:0, y:0, width:Int(pixelsWide), height:Int(pixelsHigh))
//        
//        let bitmapBytesPerRow = Int(pixelsWide) * 4
//        let bitmapByteCount = bitmapBytesPerRow * Int(pixelsHigh)
//        
//        //Clear the context
//        context.clear(rect)
//        
//        // Draw the image to the bitmap context. Once we draw, the memory
//        // allocated for the context for rendering will then contain the
//        // raw image data in the specified color space.
//        context.draw(inImage, in: rect)
////        CGContextDrawImage(context, rect, inImage)
//        
//        // Now we can get a pointer to the image data associated with the bitmap
//        // context.
//        
//        
//        let provider = self.cgImage!.dataProvider
//        let providerData = provider!.data
//        guard let dataType = CFDataGetBytePtr(providerData) else {
//            return nil
//        }
//        let point: CGPoint = CGPoint(x: 0, y: 0)
//        
//        for x in 0 ..< Int(pixelsWide) {
//            for y in 0 ..< Int(pixelsHigh)  {
//                let offset = 4 * ((Int(pixelsWide) * Int(y)) + Int(x))
//                let alpha = dataType[offset]
//                let red = dataType[offset+1]
//                let green = dataType[offset+2]
//                let blue = dataType[offset+3]
//                let (newRedColor, newGreenColor, newBlueColor, newAlphaValue) = closure(CGPoint(x: CGFloat(x), y: CGFloat(y)), red, green,  blue, alpha)
//                dataType[offset] = newAlphaValue
//                dataType[offset + 1] = newRedColor
//                dataType[offset + 2] = newGreenColor
//                dataType[offset + 3] = newBlueColor
//            }
//        }
//        
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
//        
//        let finalcontext = CGContext(data: dataType, width: pixelsWide, height: pixelsHigh, bitsPerComponent: 8,  bytesPerRow: bitmapBytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
//        
//        let imageRef = CGBitmapContextCreateImage(finalcontext!)
//        return UIImage(CGImage: imageRef, scale: self.scale,orientation: self.imageOrientation)
//    }
    
}
