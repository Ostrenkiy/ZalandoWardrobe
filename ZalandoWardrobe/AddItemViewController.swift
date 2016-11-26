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
    var itemImage: UIImage?
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.itemImageView.image = itemImage
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

