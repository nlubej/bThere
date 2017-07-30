//
//  RemindersCT.swift
//  bThere
//
//  Created by Nejc Lubej on 11/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift

class Reminder: Object {
    
    dynamic var id = 0
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
