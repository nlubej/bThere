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
    
    private var shadowImageView: UIImageView?
    var match : Match!
    
    var backgroundColor : UIColor!
    var selectedTextColor : UIColor!
    var unselectedTextColor: UIColor!
    
    @IBAction func cancelToParentController(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveToParentController(_ sender: UIStoryboardSegue) {
        
    }
    
    override func viewDidLoad() {
        
        backgroundColor =  AppSettings.useCustomBackground ? UIColor.white : UIColor.secondaryColor
        selectedTextColor = AppSettings.useCustomBackground ? UIColor.primaryColor : UIColor.black
        unselectedTextColor = AppSettings.useCustomBackground ? UIColor.lightGray : UIColor.lightGray
        
    
        self.navigationController!.navigationBar.topItem!.title = ""
        settings.style.buttonBarItemBackgroundColor = backgroundColor
        settings.style.selectedBarBackgroundColor =  UIColor.primaryColor
        
        buttonBarView.autoresizesSubviews = true
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = UIColor.lightGray
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = self.unselectedTextColor
            newCell?.label.textColor = self.selectedTextColor
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(savePressed(_:)))
        
        super.viewDidLoad()
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
    
    func savePressed(_ button: UIBarButtonItem)
    {
        performSegue(withIdentifier: "EditMatchSegue", sender: self)
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
        let child_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child3")
        
        if let viewController = child_1.contentViewControler as? MatchPlayersTableViewController {
            
            viewController.match = match
        }
        
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "child2")
        
        if let viewController = child_2.contentViewControler as? ChatViewController {
            viewController.match = match
        }
        
        return [child_1, child_2]
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
    
    private func hexToInt(hex : String) -> Int {
        return Int(UInt64(hex, radix:16)!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditMatchSegue" {
            
            if let toViewController = segue.destination.contentViewControler as? CreateMatchViewController {
                toViewController.match = match
            }
        }
    }
}
