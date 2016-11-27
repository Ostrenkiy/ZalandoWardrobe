//
//  ClothingItemViewController.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class ClothingItemViewController: UIViewController {
    
    @IBOutlet weak var clothingItemImageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var item: ClothingItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let i = item {
            clothingItemImageView.kf.setImage(with: i.imageURL)
            if !i.isZalando {
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(ClothingItemViewController.delete as (ClothingItemViewController) -> () -> ()))
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func delete() {
        if let i = item {
            SVProgressHUD.show()
            APIDataDownloader.clothes.delete(item: i, success: {
                [weak self] in
                SVProgressHUD.showSuccess(withStatus: "Deleted!")
                self?.navigationController?.popViewController(animated: true)
            }, error: {
                errorMsg in
                SVProgressHUD.showError(withStatus: errorMsg)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func browseButtonPressed(_ sender: Any) {
    }
}
