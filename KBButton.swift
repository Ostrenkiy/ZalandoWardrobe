//
//  KBButton.swift
//  TURNSTR
//
//  Created by Apple on 22/02/16.
//  Copyright © 2016 Neophyte. All rights reserved.
//
import UIKit

@IBDesignable

class KBButton: UIButton {
    
    @IBInspectable var addShadow : Bool = false {
        didSet {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.8;
            layer.shadowRadius = 12;
            layer.shadowOffset = CGSize(width: 3, height: 3)
            layer.masksToBounds = false
        }
    }
    @IBInspectable var borderColor  : UIColor?{
        
        didSet{
            layer.borderColor = borderColor?.cgColor;
        }
    }
    @IBInspectable var borderWidth  : CGFloat = 1.0{
        didSet{
            layer.borderWidth = borderWidth;
        }
    }
    @IBInspectable var cornerRadius : CGFloat = 1.0{
        didSet{
            layer.cornerRadius = cornerRadius;
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var selectedColor : UIColor = UIColor.clear{
        didSet{
            setBackgroundImage(imageFromColor(color: selectedColor), for: .selected)
        }
    }
    @IBInspectable var normalColor : UIColor = UIColor.clear{
        didSet{
            setBackgroundImage(imageFromColor(color: normalColor), for: .normal)
        }
    }
    @IBInspectable var underline : Bool = false{
        didSet{
            if (underline){
                let btnTitle : NSMutableAttributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: self.currentTitle!))
                let range : NSRange = NSMakeRange(0, (self.currentTitle?.characters.count)!)
                btnTitle.addAttributes([NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue, NSForegroundColorAttributeName : (self.titleLabel?.textColor)!], range: range)
                self.setAttributedTitle(btnTitle, for: self.state)
            }
            else{
                self.setTitle(self.currentTitle, for: self.state)
            }
        }
    }
    
    @IBInspectable var badgeValue: String? = "0"{
        didSet{
            
            let lblBadge = UILabel(frame: CGRect(x:frame.width - 13.0, y:0.0, width:12.0, height:12.0))
            lblBadge.text = badgeValue
            lblBadge.textAlignment = .center
            lblBadge.adjustsFontSizeToFitWidth = true
            lblBadge.backgroundColor = UIColor(red: 249.0/255.0, green: 142.0/255.0, blue: 32.0/255.0, alpha: 1.0)
            lblBadge.textColor = UIColor.white
            lblBadge.font = UIFont.systemFont(ofSize: 8.0)
            lblBadge.sizeToFit()
            lblBadge.layer.cornerRadius = lblBadge.frame.size.height/2
            
            lblBadge.clipsToBounds = true
            addSubview(lblBadge)
        }
    }
    
    func imageFromColor(color: UIColor) -> UIImage{
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image!
    }
    
}
