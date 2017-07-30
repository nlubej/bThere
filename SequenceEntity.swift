//
//  SequenceEntity.swift
//  bThere
//
//  Created by Nejc Lubej on 30/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift

class SequenceEntity: Object {
    
    dynamic var name = ""
    dynamic var sequenceId = 0
    
    override static func primaryKey() -> String? {
        return "name"
    }
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
