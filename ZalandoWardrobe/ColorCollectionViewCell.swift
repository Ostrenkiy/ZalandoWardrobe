//
//  ColorCollectionViewCell.swift
//  ZalandoWardrobe
//
//  Created by Филипп Федяков on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation
import UIKit

class ColorCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var isSelectedImageView: UIImageView!
    @IBOutlet weak var colorImageView: UIImageView!
    
    func setupViewWithColorItem(colorItem:ColorItem) {
        self.colorImageView.backgroundColor = colorItem.color
        self.isSelectedImageView.isHidden = !colorItem.isSelected;
        self.colorImageView.layer.cornerRadius = self.frame.height / 2
        self.colorImageView.layer.masksToBounds = true
        self.colorImageView.layer.borderColor = Styler.blackColor().cgColor
        self.colorImageView.layer.borderWidth = 1.0
    }
}
