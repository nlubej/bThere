//
//  ReminderConst.swift
//  bThere
//
//  Created by Nejc Lubej on 25/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation

class ReminderTypeConst {
    
    static var None = 1
    static var OneDayBefore = 2
    static var TwoDaysBefore = 3
    static var ThreeDaysBefore = 4
    
    public static func getDescription(sportId : Int) -> String {
        switch sportId {
        case None:
            return "None"
        case OneDayBefore:
            return "1 Days Before"
        case TwoDaysBefore:
            return "2 Days Before"
        case ThreeDaysBefore:
            return "3 Days Before"
        default:
            return "Not Defined"
        }
    }
}
