//
//  AddItemViewController.swift
//  ZalandoWardrobe
//
//  Created by Филипп Федяков on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import Foundation

import UIKit
import ImagePicker

class ColorItem {
    private(set) var color:UIColor
    var isSelected: Bool
    
    init(color:UIColor) {
        self.color = color
        self.isSelected = false
    }
}

class AddItemViewController: UITableViewController {
    let colorReuseIdentifier = "colorReuseIdentifier"

    var itemImage: UIImage?
    var colors: [ColorItem]?
    
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        
        self.colors = [UIColor.red, UIColor.black, UIColor.blue].map {ColorItem(color: $0)}
        setupColorsSet()
        setupView()
    }
    
    private func setupView() {
        self.itemImageView.image = itemImage
        // вроде ни разу не правильно, тип не в центр кидает
        
        let collectionViewWidth = self.colorsCollectionView.frame.width
        self.colorsCollectionView.setContentOffset(CGPoint(x: collectionViewWidth / 2, y: 0), animated: false)
    }
    
    private func setupColorsSet() {
        self.colors = (IttenColors + DefaultColors).map{ ColorItem(color: $0)}
    }
    
    
}

extension AddItemViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorsCollectionView.dequeueReusableCell(withReuseIdentifier: colorReuseIdentifier,
                                                                 for: indexPath) as! ColorCollectionViewCell
        if let colorItem = self.colors?[indexPath.row] {
            cell.backgroundColor = colorItem.color
            cell.isSelectedImageView.backgroundColor = colorItem.isSelected ? UIColor.green : UIColor.clear
            cell.layer.cornerRadius = cell.frame.height / 2
            cell.layer.masksToBounds = true
        }
        
        return cell
    }
}

extension AddItemViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let colorItem = self.colors?[indexPath.row] {
            colorItem.isSelected = !colorItem.isSelected
            let cell = colorsCollectionView.cellForItem(at: indexPath) as! ColorCollectionViewCell
            UIView.animate(withDuration: 0.5, animations: {                
                //implement custom animation
                
                cell.isSelectedImageView.backgroundColor = colorItem.isSelected ? UIColor.green : UIColor.clear

            })
        }
    }
}
