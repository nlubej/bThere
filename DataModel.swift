//
//  DataModel.swift
//  bThere
//
//  Created by Nejc Lubej on 17/05/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import UIKit

class DataModel {
    
    public static func getUsers() -> [User] {
        return [
            User("Donald Trump", _username: "wallguy", _nickname : "pretty boy", _picture : UIImage(named : "picMale3")),
            User("Marija Sveta", _username: "sveta.marija", _nickname : "the one", _picture : UIImage(named : "picFemale")),
            User("Vladimir Putin", _username: "putin", _nickname : "The russian", _picture : UIImage(named : "picMale2")),
            User("Klara Jazbinec", _username: "klarci", _nickname : "Klarči", _picture : UIImage(named : "picFemale2")),
            User("Magda Mlakar", _username: "magdaM", _nickname : "Magdalena", _picture : UIImage(named : "picFemale3")),
            User("Joško Korošnik", _username: "joskoKorosnik", _nickname : "Joško", _picture : UIImage(named : "picMale"))
        ]
    }
    
    public static func getComments() -> [CommentEntry] {
        
        var users = getUsers()
        return [
            CommentEntry(_user: users[0], _entryDate: Date(), _comment : "Pridem malo kasneje. Gradim zid! 🐭"),
            CommentEntry(_user: users[1], _entryDate: Date(), _comment : "Jaz bom malo prej tam, ker sem z avtom 🚙. Lahko kdo prej pride pa se bomo prej mal ogrel! 😃"),
            CommentEntry(_user: users[2], _entryDate: Date(), _comment : "Jaz pa ne morem prit, glih enga medveda napadam...😩😩😩😩"),
            CommentEntry(_user: users[3], _entryDate: Date(), _comment : "Mogoč pridem, mogoč pa tut ne. Bom še vidu.😎"),
            CommentEntry(_user: users[4], _entryDate: Date(), _comment : "A bo kdo prnesu žogo? ⚽️⚽️ Ker drugače ne bomo mogli nič špilat...😕 "),
            CommentEntry(_user: users[5], _entryDate: Date(), _comment : "Čuj ti, bom jst prinesu žogo! ⚽️ Na pune jih mam. 😁  Ti mi samo sporoči kero hočeš - trdo al mehko ✌️")
        ]
    }
    
    public static func getMatchPlayers() -> [MatchPlayer] {
        var users = getUsers()
        
        return [
            MatchPlayer( _status: MatchEventStatus.None, user : users[0]),
            MatchPlayer( _status: MatchEventStatus.Going, user : users[1]),
            MatchPlayer( _status: MatchEventStatus.Maybe, user : users[2]),
            MatchPlayer( _status: MatchEventStatus.NotGoing, user : users[3]),
            MatchPlayer( _status: MatchEventStatus.NotGoing, user : users[4]),
            MatchPlayer( _status: MatchEventStatus.Going, user : users[5]),
            //MatchPlayer( _status: MatchEventStatus.Going, _user : users[6])
        ]
    }
}
