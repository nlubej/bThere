//
//  Match.swift
//  bThere
//
//  Created by Nejc Lubej on 06/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation

class Match {
    
    var Name  = ""
    var Start  = Date()
    var Status = 0
    
    init(name: String, start: Date, status: Int) {
        Name = name
        Start = start
        Status = status
    }
}

class SportGroup {
    var sportName : String!
    var groups : [Match]!
    
    init(name: String, groupArray : [Match]) {
        sportName = name
        groups = groupArray
    }
}

class Group {
    var groupName : String!
    var groupMembersCount : Int!
    
    init(name: String, count : Int) {
        groupName = name
        groupMembersCount = count
    }
}

class GroupMember {
    var name : String!
    var nickName : String!
    
    init(memberName: String, memberNickName : String) {
        name = memberName
        nickName = memberNickName
    }
}
