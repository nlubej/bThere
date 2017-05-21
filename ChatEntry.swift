//
//  ChatEntry.swift
//  bThere
//
//  Created by Nejc Lubej on 16/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import UIKit

class CommentEntry {
    
    var user : User!
    var entryDate : Date!
    var comment : String!
    
    init(_user: User, _entryDate: Date, _comment: String) {
        user = _user
        entryDate = _entryDate
        comment = _comment
    }
}
