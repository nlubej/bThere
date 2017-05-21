//
//  AppNavController.swift
//  bThere
//
//  Created by Nejc Lubej on 18/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class AppNavController: UINavigationController, HalfModalPresentable {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isHalfModalMaximized() ? .default : .lightContent
    }
}
