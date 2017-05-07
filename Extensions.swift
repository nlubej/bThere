//
//  Extensions.swift
//  bThere
//
//  Created by Nejc Lubej on 06/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var contentViewControler: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }
        else{
            return self
        }
    }
}
