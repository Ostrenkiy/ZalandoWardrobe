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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
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
        setupView() 
    }
    
    
    func setupView() {
        self.itemImageView.layer.borderWidth = 1
        self.itemImageView.layer.borderColor = Styler.blackColor().cgColor
    }
}
