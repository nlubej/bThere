//
//  MatchObj.swift
//  bThere
//
//  Created by Nejc Lubej on 11/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift

class Match: Object {

    dynamic var matchId = 0
    dynamic var name = ""
    dynamic var start = Date()
    dynamic var sportId : Int = 0
    dynamic var location = ""
    dynamic var note = ""
    dynamic var isPublic = false
    dynamic var isAllDay = false
    dynamic var groupId : Int = 0
    let players = List<MatchUser>()
    let comments = List<MatchComment>()
    dynamic var createdBy : User!
    dynamic var createdOn = Date()
    dynamic var reminderTypeId : Int = 0
    dynamic var repeatTypeId : Int = 0
    
    public static func copyObject(match: Match) -> Match {
        let matchCopy = Match()
        
        matchCopy.matchId = match.matchId
        matchCopy.name = match.name
        matchCopy.start = match.start
        matchCopy.location = match.name
        matchCopy.sportId = match.sportId
        matchCopy.groupId = match.groupId
        matchCopy.reminderTypeId = match.reminderTypeId
        matchCopy.isAllDay = match.isAllDay
        matchCopy.isPublic = match.isPublic
        matchCopy.repeatTypeId = match.repeatTypeId
        matchCopy.note = match.note
        //matchCopy.players = match.players
        //matchCopy.comments = match.comments
        matchCopy.createdBy = match.createdBy
        matchCopy.createdOn = match.createdOn
        
        return matchCopy
        
    }
    
    convenience init(name : String, start : Date, location : String, sportId : Int, groupId : Int, note : String, isPublic : Bool, isAllDay : Bool,  reminderTypeId : Int = 0, repeatTypeId : Int = 0) {
        self.init()
        
        self.name = name
        self.location = location
        self.start = start
        self.sportId = sportId
        self.groupId = groupId
        self.note = note
        self.isPublic = isPublic
        self.isAllDay = isAllDay
        self.reminderTypeId = reminderTypeId
        self.repeatTypeId = repeatTypeId
        self.createdBy = AppSettings.currentUser
        self.createdOn = Date()
    }
    
    override static func primaryKey() -> String? {
        return "matchId"
    }
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}

class MatchWithHeader {
    var headerName = ""
    var isHeader = false
    var match : Match!
    
    init(_headerName : String, _match : Match)
    {
        headerName = _headerName
        isHeader = !_headerName.isEmpty
        match = _match
    }
}
