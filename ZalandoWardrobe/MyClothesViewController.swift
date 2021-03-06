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
    
    var items : [ClothingItem] = []
    var index : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MyClothesViewController.addItem(_:)))
        navigationItem.rightBarButtonItem = item
        
        collectionView.register(UINib(nibName: "ClothingItemCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "ClothingItemCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        title = "Wardrobe"
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(MyClothesViewController.refreshClothes), for: UIControlEvents.valueChanged)
        collectionView.refreshControl = rc
        refreshClothes()
        collectionView.refreshControl?.beginRefreshing()
        initializeTapRecognizer()
        // Do any additional setup after loading the view.
    }
    
    func initializeTapRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MyClothesViewController.handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = true
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer!) {
        let location = sender.location(ofTouch: 0, in: collectionView)
        let locationInCollection = CGPoint(x: location.x, y: location.y)
        let indexPathOptional = collectionView.indexPathForItem(at: locationInCollection)
        if let indexPath = indexPathOptional {
            performSegue(withIdentifier: "BrowseItemSegue", sender: items[indexPath.item])
        }
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        showImagePickerController()
    }
    
    func refreshClothes() {
        APIDataDownloader.clothes.retrieve(success: {
            [weak self]
            newItems in
            self?.items = newItems
            self?.collectionView.reloadData()
            self?.collectionView.refreshControl?.endRefreshing()
        }, error: {
            errorMsg in
            print(errorMsg)
        })
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
        case "BrowseItemSegue" :
            let dvc = segue.destination as! ClothingItemViewController
            dvc.item = sender as? ClothingItem

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
        cell.initWithItem(clothingItem: i)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth =  collectionView.frame.size.width
        let viewHeight = collectionView.frame.size.height
        return CGSize(width: viewWidth / 2, height: viewHeight / 2)
    }
    
}


