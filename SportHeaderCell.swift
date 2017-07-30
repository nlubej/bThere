//
//  SportHeaderCell.swift
//  bThere
//
//  Created by Nejc Lubej on 28/07/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import UIKit

class SportHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var sportDescription: UILabel! {
        didSet {
            sportDescription.textColor = UIColor.primaryColor
        }
    }
}
