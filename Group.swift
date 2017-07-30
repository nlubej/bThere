//
//  Group.swift
//  bThere
//
//  Created by Nejc Lubej on 11/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift

class Group: Object {
    dynamic var groupId = 0
    dynamic var name = ""
    let users = List<User>()

    convenience init(_ id : Int, _ name : String) {
        self.init()
        
        self.groupId = id
        self.name = name
    }
    
    override static func primaryKey() -> String? {
        return "groupId"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["userCount"]
    }
    
}
