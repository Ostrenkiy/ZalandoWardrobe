//
//  ViewController.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import UIKit
import ImagePicker

class ViewController: UIViewController {
    
    var imagePicked: UIImage?

    @IBOutlet weak var addItemButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addItem(_ sender: Any) {
        showImagePickerController()
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        switch segue.identifier! {
//        case "AddItemSegue":
//            guard let addItemVC = segue.destination as? AddItemViewController, let image = sender as? UIImage else {
//                return
//            }
//            addItemVC.itemImage = image
//        default:
//            return
//        }
//    }
}

extension ViewController : ImagePickerDelegate {
    func showImagePickerController() {
        let imagePickerController = ImagePickerController()
        imagePickerController.imageLimit = 1
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("3")
        
    }
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("3")

       // self.imagePicked = images[0]
        //self.performSegue(withIdentifier: "AddItemSegue", sender: images[0])
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        print("1")
    }
    
}

