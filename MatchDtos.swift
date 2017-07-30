//
//  Match.swift
//  bThere
//
//  Created by Nejc Lubej on 06/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import UIKit

//class Match {
//    
//    var Name  = ""
//    var Start  = Date()
//    var Status = 0
//    
//    init(name: String, start: Date, status: Int) {
//        Name = name
//        Start = start
//        Status = status
//    }
//}

class MatchSection : Equatable, Hashable{
    var name : String!
    var sportId : Int!
    
    init(sportId : Int, name: String) {
        self.name = name
        self.sportId = sportId
    }
    
    var hashValue: Int {
        get {
            return sportId.hashValue << 15 + name.hashValue
        }
    }
    
    static func ==(lhs: MatchSection, rhs: MatchSection) -> Bool {
        return lhs.sportId == rhs.sportId && lhs.name == rhs.name
    }
}

//class Group {
//    var groupName : String!
//    var groupMembersCount : Int!
//    
//    init(name: String, count : Int) {
//        groupName = name
//        groupMembersCount = count
//    }
//}


class GroupMember {
    var name : String!
    var nickName : String!
    
    init(memberName: String, memberNickName : String) {
        name = memberName
        nickName = memberNickName
    }
}

class Player {
    var name : String!
    var nickname : String!
    var picture : UIImage?
    var status : Int!
    
    init(_name: String, _nick : String, _picture : UIImage?, _status : Int) {
        name = _name
        nickname = _nick
        picture = _picture
        status = _status
    }
}


class UserDto {
    var fullName : String!
    var username : String!
    var nickname : String?
    var picture : UIImage?
    
    init(_ _fullName: String, _username : String, _nickname : String?, _picture : UIImage?) {
        fullName = _fullName
        username = _username
        nickname = _nickname
        picture = _picture
    }
}


struct MatchEventStatus
{
    static let Going = 1
    static let NotGoing = 2
    static let Maybe = 3
    static let None = 4
    
    struct MatchEventStatusColor
    {
        static let Going = "76D457"
        static let NotGoing = "FA6666"
        static let Maybe = "D4D261"
        static let None = "ffffff"
    }
    
    static func getStatusImage(_ statusId : Int) -> UIImage {
        return UIImage(named: statusToIcon(statusId))!
    }
    
    
    static func statusToColor(statusId : Int?) -> String {
        switch statusId! {
        case Going:
            return MatchEventStatus.MatchEventStatusColor.Going
        case NotGoing:
            return MatchEventStatus.MatchEventStatusColor.NotGoing
        case Maybe:
            return MatchEventStatus.MatchEventStatusColor.Maybe
        case None:
            return MatchEventStatus.MatchEventStatusColor.None
        default:
            return MatchEventStatus.MatchEventStatusColor.None
        }
    }
    
    static func statusToIcon(_ statusId : Int?) -> String {
        switch statusId! {
        case Going:
            return "CheckIcon4-App-60x60"
        case NotGoing:
            return "CrossIcon5-App-60x60"
        case Maybe:
            return "QuestionIcon5-App-60x60"
        default:
            return "CheckIcon4-App-60x60" //TODO no image
        }
    }
}

//class MatchPlayer : User {
//    var status : Int
//    
//    init(_status : Int, user : User!) {
//        status = _status
//        super.init(user.fullName, _username: user.username, _nickname: user.nickname, _picture: user.picture)
//
//    }
//}
