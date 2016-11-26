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

class AddItemViewController: UITableViewController {
    let colorReuseIdentifier = "colorReuseIdentifier"

    var itemImage: UIImage?
    @IBOutlet weak var colorsCollectionView: UICollectionView!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        setupView()
        //colorsCollectionView.delegate = self
        colorsCollectionView.dataSource = self
    }
    
    private func setupView() {
        self.itemImageView.image = itemImage
    }
    
    
}

extension AddItemViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colorsCollectionView.dequeueReusableCell(withReuseIdentifier: colorReuseIdentifier,
                                                                 for: indexPath) as! ColorCollectionViewCell
        cell.backgroundColor = UIColor.red
        return cell
    }
}

//extension AddItemViewController : ImagePickerDelegate {
//    func showImagePickerController() {
//        let imagePickerController = ImagePickerController()
//        imagePickerController.imageLimit = 1
//        imagePickerController.delegate = self
//        present(imagePickerController, animated: true, completion: nil)
//    }
//    
//    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
//        print("3")
//        
//    }
//    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
//        print("2")
//        
//    }
//    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
//        print("1")
//    }
//
//}

