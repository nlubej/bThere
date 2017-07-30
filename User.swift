//
//  User.swift
//  bThere
//
//  Created by Nejc Lubej on 11/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    dynamic var userId = 0
    dynamic var username = ""
    dynamic var name = ""
    dynamic var lastName = ""
    dynamic var nickname = ""
    dynamic var picture: Data? = nil
    
    public var fullName: String {
        return "\(name) \(lastName)"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["fullName"]
    }
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    convenience init(_ id : Int, _ username : String, _ name : String, _ lastName : String, _ nickName : String, _ picture : UIImage?) {
        self.init()
        
        self.userId = id
        self.username = username
        self.name = name
        self.lastName = lastName
        self.nickname = nickName
        
        if picture != nil {
            self.picture = UIImagePNGRepresentation(picture!) as Data?
        }
    }
}
