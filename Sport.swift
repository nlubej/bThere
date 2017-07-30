//
//  SportCT.swift
//  bThere
//
//  Created by Nejc Lubej on 11/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift

class Sport: Object {
    
    public dynamic var id = 0
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
