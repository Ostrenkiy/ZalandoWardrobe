//
//  SingleRecommendationViewController.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import UIKit

class SingleRecommendationViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var items : [ClothingItem] = []
    var index : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "ClothingItemCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "ClothingItemCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        initializeTapRecognizer()
        // Do any additional setup after loading the view.
    }

    func initializeTapRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SingleRecommendationViewController.handleTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = true
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    func handleTap(_ sender: UITapGestureRecognizer!) {
        let location = sender.location(ofTouch: 0, in: collectionView)
        let locationInCollection = CGPoint(x: location.x, y: location.y)
        let indexPathOptional = collectionView.indexPathForItem(at: locationInCollection)
        if let indexPath = indexPathOptional, items[indexPath.item].isZalando {
            performSegue(withIdentifier: "BrowseItemSegue", sender: items[indexPath.item])
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BrowseItemSegue" {
            let dvc = segue.destination as! ClothingItemViewController
            dvc.item = sender as? ClothingItem
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

extension SingleRecommendationViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth =  collectionView.frame.size.width
        let viewHeight = collectionView.frame.size.height
        return CGSize(width: viewWidth / 2, height: viewHeight / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "BrowseItemSegue", sender: items[indexPath.item])
    }
    
}

extension SingleRecommendationViewController: UICollectionViewDataSource {
    
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
}
