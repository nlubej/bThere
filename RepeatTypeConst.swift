//
//  RepeatConst.swift
//  bThere
//
//  Created by Nejc Lubej on 25/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation

class RepeatTypeConst {
    static var Never = 1
    static var EveryDay = 2
    static var EveryWeek = 3
    static var EveryMonth = 4
    static var EveryYear = 5
    
    public static func getDescription(sportId : Int) -> String {
        switch sportId {
        case Never:
            return "Never"
        case EveryDay:
            return "Every Day"
        case EveryWeek:
            return "Every Week"
        case EveryMonth:
            return "Every Month"
        case EveryYear:
            return "Every Year"
        default:
            return "Not Defined"
        }
    }
}
