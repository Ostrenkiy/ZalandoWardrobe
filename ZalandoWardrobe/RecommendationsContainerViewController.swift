//
//  RecommendationsContainerViewController.swift
//  ZalandoWardrobe
//
//  Created by Alexander Karpov on 26.11.16.
//  Copyright © 2016 AKarpov. All rights reserved.
//

import UIKit
import FLKAutoLayout

class RecommendationsContainerViewController: UIViewController {

    var pageViewController : UIPageViewController?
    var pageControl : UIPageControl?
    
    var sets : [ItemSet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let set1 = ItemSet(items: [
            ClothingItem(imageURL: URL(string: "https://mosaic02.ztat.net/vgs/media/pdp-gallery/BQ/02/2D/00/5K/11/BQ022D005-K11@12.jpg")!, isZalando: true),
            ClothingItem(imageURL: URL(string: "https://i2.ztat.net/detail/BE/82/4G/00/2C/11/BE824G002-C11@8.jpg")!, isZalando: false),
            ClothingItem(imageURL: URL(string: "https://mosaic02.ztat.net/vgs/media/pdp-gallery/AD/12/2E/02/7Q/11/AD122E027-Q11@11.jpg")!, isZalando: false),
            ClothingItem(imageURL: URL(string: "https://mosaic01.ztat.net/vgs/media/pdp-gallery/NI/11/2B/02/VC/12/NI112B02V-C12@10.jpg")!, isZalando: true)
            ])
        
        let set2 = ItemSet(items: [
            ClothingItem(imageURL: URL(string: "https://i2.ztat.net/detail/BE/82/4G/00/2C/11/BE824G002-C11@8.jpg")!, isZalando: false),
            ClothingItem(imageURL: URL(string: "https://mosaic02.ztat.net/vgs/media/pdp-gallery/AD/12/2E/02/7Q/11/AD122E027-Q11@11.jpg")!, isZalando: false),
            ClothingItem(imageURL: URL(string: "https://mosaic01.ztat.net/vgs/media/pdp-gallery/NI/11/2B/02/VC/12/NI112B02V-C12@10.jpg")!, isZalando: true),
            ClothingItem(imageURL: URL(string: "https://mosaic02.ztat.net/vgs/media/pdp-gallery/BQ/02/2D/00/5K/11/BQ022D005-K11@12.jpg")!, isZalando: true)
            ])
        sets = [set1, set2]
        
        initPageViewController()
    }

    func initPageViewController() {
        pageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecommendationsPageViewController") as? UIPageViewController
        
        pageViewController?.delegate = self
        pageViewController?.dataSource = self
        if let startingVC = controllerAtIndex(index: 0) {
            pageViewController?.setViewControllers([startingVC], direction: .forward, animated: false, completion: nil)
            
        }
        self.addChildViewController(pageViewController!)
        self.view.addSubview((pageViewController?.view)!)
        pageViewController?.view.alignTop("0", leading: "0", bottom: "30", trailing: "0", toView: self.view)
        pageViewController?.didMove(toParentViewController: self)
        pageControl = UIPageControl()
        self.view.addSubview(pageControl!)
        pageControl?.alignBottomEdge(withView: self.view, predicate: "0")
        pageControl?.alignCenterX(withView: self.view, predicate: "0")
        pageControl?.pageIndicatorTintColor = UIColor.lightGray
        pageControl?.currentPageIndicatorTintColor = UIColor.black
        pageControl?.backgroundColor = UIColor.clear
        pageControl?.numberOfPages = sets.count
        pageControl?.currentPage = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func controllerAtIndex(index: Int) -> SingleRecommendationViewController? {
        if index >= 0 && index < sets.count {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SingleRecommendationViewController") as! SingleRecommendationViewController
            vc.items = sets[index].items
            vc.index = index
            return vc
        } else {
            return nil
        }
    }
    var pendingIndex: Int? = nil
    var currentIndex: Int? = nil
}

extension RecommendationsContainerViewController : UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentVC = viewController as! SingleRecommendationViewController
        let index = currentVC.index - 1
        
        return controllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentVC = viewController as! SingleRecommendationViewController
        let index = currentVC.index + 1
        
        return controllerAtIndex(index: index)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = (pendingViewControllers.first as? SingleRecommendationViewController)?.index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl?.currentPage = index
            }
        }
    }
//    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
//        pendingIndex = pages.indexOf(pendingViewControllers.first!)
//    }
//    
//    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if completed {
//            currentIndex = pendingIndex
//            if let index = currentIndex {
//                pageControl.currentPage = index
//            }
//        }
//    }
    
}

extension RecommendationsContainerViewController : UIPageViewControllerDataSource {
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        print(sets.count)
//        return sets.count
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
}
