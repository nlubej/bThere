//
//  MatchComment.swift
//  bThere
//
//  Created by Nejc Lubej on 13/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift

class MatchComment: Object {
    
    dynamic var matchCommentId = 0
    dynamic var comment = ""
    //dynamic var matchId = 0
    dynamic var createdBy : User!
    dynamic var createdOn = Date()
    
    
    convenience init(_ id : Int, _ comment : String, _ createdOn : Date, _ createdBy : User) {
        
        self.init()
        
        self.matchCommentId = id
        self.comment = comment
        self.createdOn = createdOn
       // self.matchId = matchId
        self.createdBy = createdBy
    }

    
    override static func primaryKey() -> String? {
        return "matchCommentId"
    }
}
