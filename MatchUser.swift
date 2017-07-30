//
//  UserMatch.swift
//  bThere
//
//  Created by Nejc Lubej on 13/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift

class MatchUser: Object {

    dynamic var matchUserId = 0
    dynamic var user : User!
    dynamic var responseStatusId : Int = 0
    dynamic var responseDate = Date()
    
    
    convenience init(_ matchUserId : Int, _ user : User, _ responseStatusId: Int) {
        self.init()
        
        self.matchUserId = matchUserId
        self.user = user
        //self.match = match
        self.responseStatusId = responseStatusId
    }

    
    override static func primaryKey() -> String? {
        return "matchUserId"
    }
}
