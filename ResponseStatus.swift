//
//  ResponseStatus.swift
//  bThere
//
//  Created by Nejc Lubej on 15/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift

class ResponseStatus: Object {
    
    dynamic var id = 0
    dynamic var name = ""
    
    convenience init(_ id : Int, _ name : String) {
        self.init()
        
        self.id = id
        self.name = name
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
