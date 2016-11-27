//
//  RecommendationsViewController.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 27.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import UIKit

class RecommendationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshPressed(_ sender: Any) {
        embedded?.refreshSets()
    }
    
    var embedded: RecommendationsContainerViewController?
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EmbedRecommendationSegue" {
            let dvc = segue.destination as! RecommendationsContainerViewController
            self.embedded = dvc
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
