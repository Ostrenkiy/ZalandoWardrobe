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
    private lazy var clothingSectionsArray = Array(Clothes.getAllClothes().keys)
    private var selectedClothingSection:String = "Hats"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        setupView()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (self.parent as! AddItemViewController).selectedClothingType = clothes[selectedClothingSection]![0]
    }
    
    private func setupView() {
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return clothes.keys.count
        default:
            return clothes[selectedClothingSection]!.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return clothingSectionsArray[row]
        default:
            return clothes[selectedClothingSection]![row].readableName
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedClothingSection = clothingSectionsArray[row]
            pickerView.reloadComponent(1)
        default:
            print(clothes[selectedClothingSection]![row].serverName)
            (self.parent as! AddItemViewController).selectedClothingType = clothes[selectedClothingSection]![row]
        }
    }
}
