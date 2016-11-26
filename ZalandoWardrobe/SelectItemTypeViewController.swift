//
//  SelectItemTypeViewController.swift
//  ZalandoWardrobe
//
//  Created by Филипп Федяков on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import UIKit
import SnapKit

class SelectItemTypeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!
    
    private let clothes =  Clothes.getAllClothes()
    private lazy var clothesTypeArray = Array(Clothes.getAllClothes().keys)
    private var selectedClothingType:String = "Sport"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        setupView()
        // Do any additional setup after loading the view.
    }

    
    private func setupView() {
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return clothes.keys.count
        default:
            return clothes[selectedClothingType]!.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return clothesTypeArray[row]
        default:
            return clothes[selectedClothingType]![row].readableName
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedClothingType = clothesTypeArray[row]
            pickerView.reloadComponent(1)
        default:
            print(clothes[selectedClothingType]![row].serverName)
            (self.parent as! AddItemViewController).selectedClothingType = clothes[selectedClothingType]![row].serverName
        }
    }
}
