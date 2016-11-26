//
//  UIImage_PixelColor.h
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PixelColor)

- (UIColor *)colorAtPoint:(CGPoint)pixelPoint;

@end
