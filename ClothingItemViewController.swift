//
//  ClothingItemViewController.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import UIKit
import Kingfisher
class ClothingItemViewController: UIViewController {
    
    @IBOutlet weak var clothingItemImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var shopView: UIView!
    
    var item: ClothingItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let i = item {
            clothingItemImageView.kf.setImage(with: i.imageURL)
            if i.isZalando {
                shopView.isHidden = false
            } else {
                shopView.isHidden = true
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func browseButtonPressed(_ sender: Any) {
    }
}
