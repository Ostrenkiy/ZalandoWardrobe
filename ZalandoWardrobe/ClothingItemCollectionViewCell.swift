//
//  ClothingItemCollectionViewCell.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import UIKit
import Kingfisher

class ClothingItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var zalandoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initWithItem(clothingItem: ClothingItem) {
        if let i = clothingItem.image {
            itemImageView.image = i
        } else {
            itemImageView.kf.setImage(with: clothingItem.imageURL)
        }
        if !clothingItem.isZalando {
            zalandoButton.isHidden = true
        }
    }
    
//    func initWithNewClothingItem(clothingItem: NewClothingItem) {
//        itemImageView.image = clothingItem.image
//        zalandoButton.isHidden = true
//    }
}
