//
//  ParentViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 20/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ParentViewController: ButtonBarPagerTabStripViewController {
    
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)
    private var shadowImageView: UIImageView?

    override func viewDidLoad() {
        // change selected bar color
        settings.style.buttonBarBackgroundColor = UIColor(int: 16250871)
        settings.style.buttonBarItemBackgroundColor = UIColor(int: 16250871)
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 1.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
//        return [MembersViewController(), ChatTableViewController(), InfoViewController()]
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child1")
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child2")
        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child3")
        return [child_1, child_2, child_3]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if shadowImageView == nil {
            shadowImageView = findShadowImage(under: navigationController!.navigationBar)
        }
        shadowImageView?.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        shadowImageView?.isHidden = false
    }
    
    private func findShadowImage(under view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1 {
            return (view as! UIImageView)
        }
        
        for subview in view.subviews {
            if let imageView = findShadowImage(under: subview) {
                return imageView
            }
        }
        return nil
    }

    
//    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
//        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child1")
//        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child2")
//        return [child_1, child_2]
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
