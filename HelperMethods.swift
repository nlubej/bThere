//
//  HelperMethods.swift
//  bThere
//
//  Created by Nejc Lubej on 25/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import UIKit

class HelperMethods {
    
    public static func toRoundImageView(imageView : UIImageView, imageData : Data) -> UIImageView {
        imageView.image = UIImage(data: imageData)
        imageView.layer.cornerRadius = floor(imageView.frame.size.width/2);
        imageView.clipsToBounds = true;
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }
}
