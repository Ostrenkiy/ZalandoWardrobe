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
    var selectedClothingType: ClothingType?
    var completionBlock: ((NewClothingItem) -> Void)?

    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var selectItemTypeView: UIView!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
        setupColorsSet()
        setupView()
        startRecognition()
    }
    
    private func setupView() {
        self.itemImageView.image = itemImage
        // вроде ни разу не правильно, тип не в центр кидает
        
        let collectionViewWidth = self.colorsCollectionView.frame.width
        self.colorsCollectionView.setContentOffset(CGPoint(x: collectionViewWidth / 2, y: 0), animated: false)
        
        let item = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AddItemViewController.addItem))
        navigationItem.rightBarButtonItem = item
    }
    
    private func setupColorsSet() {
        self.colors = (IttenColors + DefaultColors).map{ ColorItem(color: $0)}
    }
    
    private func startRecognition() {
        let cube = CCColorCube()
        let colors = cube.extractColors(from: itemImage!, flags: 4, count:2)
        
//        let compressedImage = self.itemImage!.compressIn(bounds: CGSize(width: 50, height: 50))
//        let recognizer = ColorRecognizer(image: compressedImage)
//        let a = recognizer.getColors()
        self.colorsCollectionView.backgroundColor = colors![0] as! UIColor
    }
    
    func addItem() {
        let colorsSelected = colors!
            .filter{$0.isSelected}
            .map{$0.color}
        self.completionBlock?(NewClothingItem(colors: colorsSelected, image: itemImage!, clothingType: selectedClothingType!))
        self.navigationController?.popViewController(animated: true)
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

extension AddItemViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 40, 0, 40)
    }
    
}

