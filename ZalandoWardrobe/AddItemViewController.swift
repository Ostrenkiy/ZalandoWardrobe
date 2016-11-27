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
import SVProgressHUD

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
    var completionBlock: ((ClothingItem) -> Void)?

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
//        let cube = CCColorCube()
//        let colors = cube.extractColors(from: itemImage!, flags: 4, count:2)
        
        let compressedImage = self.itemImage!.compressIn(bounds: CGSize(width: 50, height: 50))
        let recognizer = ColorRecognizer(image: compressedImage)
        let a = recognizer.getColors()
        print(a)
        for recognizedColor in a {
            if let index = colors?.index(where: {$0.color == recognizedColor}) {
                colors?[index].isSelected = true
            }
        }
//        self.colorsCollectionView.backgroundColor = colors![0].color 
    }
    
    func addItem() {
        let colorsSelected = colors!
            .filter{$0.isSelected}
            .map{$0.color}
        SVProgressHUD.show()
        APIDataDownloader.media.create(image: itemImage!, success: {
            [weak self]
            hash in
            APIDataDownloader.clothes.create(hash: hash, category: self!.selectedClothingType!.serverName, colors: colorsSelected, image: self!.itemImage!, success: {
                [weak self]
                item in
                SVProgressHUD.showSuccess(withStatus: "Added item")
                self?.completionBlock?(item)
                _ = self?.navigationController?.popViewController(animated: true)
            }, error: {
                errorMsg in
                print(errorMsg)
                SVProgressHUD.showError(withStatus: errorMsg)
            })
        }, error: {
            errorMsg in
            print(errorMsg)
            SVProgressHUD.showError(withStatus: errorMsg)
        })
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

