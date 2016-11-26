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
    

    @IBOutlet weak var collectionView: UICollectionView!
    
    var items : [NewClothingItem] = []
    var index : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MyClothesViewController.addItem(_:)))
        navigationItem.rightBarButtonItem = item
        
        collectionView.register(UINib(nibName: "ClothingItemCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "ClothingItemCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self

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
            addItemVC.completionBlock = ({[weak self] newItem in
                self?.items.append(newItem)
                self?.collectionView.reloadData()
                print(newItem)
            })
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


extension MyClothesViewController: UICollectionViewDelegate {
    
}

extension MyClothesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClothingItemCollectionViewCell", for: indexPath) as! ClothingItemCollectionViewCell
        
        let i = items[indexPath.item]
        cell.initWithNewClothingItem(clothingItem: i)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth =  collectionView.frame.size.width
        let viewHeight = collectionView.frame.size.height
        return CGSize(width: viewWidth / 2, height: viewHeight / 2)
    }
    
}


