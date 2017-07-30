//
//  DataModel.swift
//  bThere
//
//  Created by Nejc Lubej on 17/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class DataModel {
    
    var sport1 : Sport!
    var sport2 : Sport!
    var sport3 : Sport!
    
    var response1 : ResponseStatus!
    var response2 : ResponseStatus!
    var response3 : ResponseStatus!
    var response4 : ResponseStatus!

    
    var user1 : User!
    var user2 : User!
    var user3 : User!
    var user4 : User!
    var user5 : User!
    var user6 : User!
    
    
    var group1 : Group!
    var group2 : Group!
    
    var match1 : Match!
        var match2 : Match!
        var match3 : Match!
    
    let realm : Realm!
    
    init(_ loadData : Bool = false) {
        realm = try! Realm()
        
        if loadData {
            insertData()
        }
    }
    
    public func insertData() {
        insertResponses()
        insertSports()
        insertUsers()
        insertGroups()
        insertMatches()
    
        
    }
    
    private func insertResponses() {
        
        if realm.objects(Sport.self).count != 0 {
            realm.refresh()
            let realmm = try! Realm()
            
            response1 = realmm.objects(ResponseStatus.self).filter("id = 1").first
            response2 = realm.objects(ResponseStatus.self).filter("id = 2").first
            response3 = realm.objects(ResponseStatus.self).filter("id = 3").first
            response4 = realm.objects(ResponseStatus.self).filter("id = 4").first
            return
        }
        
        response1 = ResponseStatus(1, "Going")
        response2 = ResponseStatus(2, "Not Going")
        response3 = ResponseStatus(3, "Maybe")
        response4 = ResponseStatus(4, "None")
        
        try! realm.write {
            realm.add(response1)
            realm.add(response2)
            realm.add(response3)
            realm.add(response4)
        }

    }
    
    private func insertSports() {

        if realm.objects(Sport.self).count != 0 {
            realm.refresh()
            let realmm = try! Realm()
            
            sport1 = realmm.objects(Sport.self).filter("id = 1").first
            sport2 = realm.objects(Sport.self).filter("id = 2").first
            sport3 = realm.objects(Sport.self).filter("id = 3").first
            return
        }
        
        sport1 = Sport(Sequence.instance.getNextValue(Sport.self), "Football")
        sport2 = Sport(Sequence.instance.getNextValue(Sport.self), "Basketball")
        sport3 = Sport(Sequence.instance.getNextValue(Sport.self), "Tennis")
        
        try! realm.write {
            realm.add(sport1)
            realm.add(sport2)
            realm.add(sport3)
        }

    }
    
    private func insertUsers() {
        
        if realm.objects(User.self).count != 0 {
            user1 = realm.objects(User.self).filter("userId = 1").first
            user2 = realm.objects(User.self).filter("userId = 2").first
            user3 = realm.objects(User.self).filter("userId = 3").first
            user4 = realm.objects(User.self).filter("userId = 3").first
            user5 = realm.objects(User.self).filter("userId = 3").first
            user6 = realm.objects(User.self).filter("userId = 3").first
            
            return
        }

        
        user1 = User(Sequence.instance.getNextValue(User.self), "powerlifter", "Gorazd", "Cvelbar", "powerlifter", UIImage(named : "picMale"))
        user2 = User(Sequence.instance.getNextValue(User.self), "zagorc93", "Maruša", "Zagorc", "zagorceva", UIImage(named : "picFemale"))
        user3 = User(Sequence.instance.getNextValue(User.self), "zdenka", "Zdenka", "Dolinšek", "dolinsek", UIImage(named : "picFemale2"))
        user4 = User(Sequence.instance.getNextValue(User.self), "mlubej", "Matic", "Lubej", "doktor", UIImage(named : "picMale2"))
        user5 = User(Sequence.instance.getNextValue(User.self), "dobnik.zala", "Zala", "Dobnik", "tamala", UIImage(named : "picFemale3"))
        user6 = User(Sequence.instance.getNextValue(User.self), "juice", "Aljaž", "Novšak", "juice", UIImage(named : "picMale3"))
        
        
        try! realm.write {
            realm.add(user1)
            realm.add(user2)
            realm.add(user3)
            realm.add(user4)
            realm.add(user5)
            realm.add(user6)
        }
    }
    
    private func insertGroups() {
        
        if realm.objects(Group.self).count != 0 {
            group1 = realm.objects(Group.self).filter("groupId = 1").first
            group2 = realm.objects(Group.self).filter("groupId = 2").first
            return
        }

        group1 = Group(Sequence.instance.getNextValue(Group.self), "Group 1")
        group1.users.append(user1)
        group1.users.append(user2)
        group1.users.append(user3)
        group1.users.append(user4)
        
        group2 = Group(Sequence.instance.getNextValue(Group.self), "Group 2")
        group2.users.append(user5)
        group2.users.append(user6)
        
        try! realm.write {
            realm.add(group1)
            realm.add(group2)
        }
    }
    
    private func insertMatches() {
        
        if realm.objects(Match.self).count != 0 {
            match1 = realm.objects(Match.self).filter("matchId = 1").first
            
            return
        }
        
        match1 = createMatch(Sequence.instance.getNextValue(Match.self), "Game Of The Titans", Date(), sport1.id, "Location 1", "Note 1", false, group1.groupId, user1, Date(), 0, 0)
        
        match2 = createMatch(Sequence.instance.getNextValue(Match.self), "Jordan All Mighty", Date(), sport1.id, "Location 2", "Note 2", false, group1.groupId, user1, Date(), 0, 0)
        
        match3 = createMatch(Sequence.instance.getNextValue(Match.self), "The Final Match", Date(), sport2.id, "Location 2", "Note 2", false, group1.groupId, user1, Date(), 0, 0)


        
        
        match1.players.append(MatchUser(Sequence.instance.getNextValue(MatchUser.self), user1, response1.id))
        match1.players.append(MatchUser(Sequence.instance.getNextValue(MatchUser.self), user2, response1.id))
        match1.players.append(MatchUser(Sequence.instance.getNextValue(MatchUser.self), user3, response3.id))
        match1.players.append(MatchUser(Sequence.instance.getNextValue(MatchUser.self), user4, response4.id))
        
        
        match2.players.append(MatchUser(Sequence.instance.getNextValue(MatchUser.self), user1, response1.id))
        match2.players.append(MatchUser(Sequence.instance.getNextValue(MatchUser.self), user3, response3.id))
        match2.players.append(MatchUser(Sequence.instance.getNextValue(MatchUser.self), user4, response4.id))
        
        
        match3.players.append(MatchUser(Sequence.instance.getNextValue(MatchUser.self), user1, response1.id))
        match3.players.append(MatchUser(Sequence.instance.getNextValue(MatchUser.self), user2, response1.id))
    
        match1.comments.append(MatchComment(1, "Pridem malo kasneje. Gradim zid! 🐭", Date(), user1))
        match1.comments.append(MatchComment(2, "Jaz bom malo prej tam, ker sem z avtom 🚙. Lahko kdo prej pride pa se bomo prej mal ogrel! 😃", Date(), user2))
        match1.comments.append(MatchComment(3, "Jaz pa ne morem prit, glih enga medveda napadam...😩😩😩😩", Date(), user3))
        match1.comments.append(MatchComment(4, "A bo kdo prnesu žogo? ⚽️⚽️ Ker drugače ne bomo mogli nič špilat...😕 ", Date(), user4))
        
        try! realm.write {
            realm.add(match1)
            realm.add(match2)
            realm.add(match3)
        }
        
    }
    
    private func createMatch(_ id : Int, _ name : String, _ start : Date, _ sportId : Int, _ location : String, _ note : String, _ isPublic : Bool, _ groupId : Int, _ createdBy : User, _ createdOn : Date, _ reminderTypeId : Int, _ repeatTypeId : Int) -> Match {
        
        let match = Match()
        
        match.matchId = id
        match.name = name
        match.start = start
        match.sportId = sportId
        match.location = location
        match.note = note
        match.isPublic = isPublic
        match.groupId = groupId
        match.createdBy = createdBy
        match.createdOn = createdOn
        match.reminderTypeId = reminderTypeId
        match.repeatTypeId = repeatTypeId
        
        return match
    }
    
    public func getUsers() -> Results<User> {
        return realm.objects(User.self)
    }
    
    public func getGroups() -> Results<Group> {
        return realm.objects(Group.self)
    }
    
    public func getMatches() -> Results<Match> {
        return realm.objects(Match.self)
    }
    
    public func getMatchUsers(matchId : Int) -> Results<MatchUser> {
        return realm.objects(MatchUser.self).filter("match.matchId == \(String(describing: matchId))")
    }
    
    public func getComments() -> Results<MatchComment> {
        return realm.objects(MatchComment.self)
    }
    
    public func getCurrentUser() -> User {
        return realm.objects(User.self).first!
    }
    
    public func insertComment(_ match : Match, comment : String) {
        try! realm.write {
            match.comments.append(MatchComment(Sequence.instance.getNextValue(MatchComment.self), comment, Date(), AppSettings.currentUser))
        }
    }
    
    public func changeResponseStatus(_ match : Match, _ userId : Int, _ statusId : Int) {
        try! realm.write {
            match.players.filter("user.userId == \(userId)").first?.responseStatusId = statusId
            realm.refresh()
        }
    }
    
    public func getSports() -> Results<Sport> {
        return realm.objects(Sport.self)
    }
    
    public func updateMatch(_ match : Match) {
        try! realm.write {
            
            
            //newMatch
            realm.add(match, update: true)
        }
    }
    
    public func insertMatch(match : Match) {
        match.matchId = Sequence.instance.getNextValue(Match.self)
        
        let group = realm.objects(Group.self).filter("groupId == \(match.groupId)").first
        
        for user in (group?.users)! {
            match.players.append(MatchUser(Sequence.instance.getNextValue(MatchUser.self), user, MatchEventStatus.None))
        }
        
        try! realm.write {
            realm.add(match)
        }
        
        realm.refresh()
    }
    
    public func deleteMatch(match : Match) {
        try! realm.write {
            realm.delete(match)
        }
    }
}
