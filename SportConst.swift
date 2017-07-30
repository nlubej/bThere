//
//  SportConst.swift
//  bThere
//
//  Created by Nejc Lubej on 25/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation

class SportConst {
    
    static var Football = 1
    static var Basketball = 2
    static var Tennis = 3
    
    public static func getDescription(sportId : Int) -> String {
        switch sportId {
        case Football:
            return "FOOTBALL"
        case Basketball:
            return "BASKETBALL"
        case Tennis:
            return "TENNIS"
        default:
            return "Not Defined"
        }
    }
}
