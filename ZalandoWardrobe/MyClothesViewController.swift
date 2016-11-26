//
//  MyClothesViewController.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import UIKit
import ImagePicker

class MyClothesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.navigationController != nil {
            let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MyClothesViewController.addItem(_:)))
            navigationController?.navigationItem.rightBarButtonItem = item
        }
    }
    
    @IBAction func addItem(_ sender: Any) {
        showImagePickerController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "AddItemSegue":
            guard let addItemVC = segue.destination as? AddItemViewController, let image = sender as? UIImage else {
                return
            }
            addItemVC.itemImage = image
        default:
            return
        }
    }
    
    
}

extension MyClothesViewController : ImagePickerDelegate {
    func showImagePickerController() {
        let imagePickerController = ImagePickerController()
        imagePickerController.imageLimit = 1
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePicker.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "AddItemSegue", sender: images[0])
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
    }
}

