//
//  FriendsViewController.swift
//  bThere
//
//  Created by Nejc Lubej on 30/07/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("Friends View Controller Will Appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("Friends View Controller Will Disappear")
    }
    
}
