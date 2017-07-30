//
//  SequenceGenerator.swift
//  bThere
//
//  Created by Nejc Lubej on 30/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation
import RealmSwift

class Sequence {
    
    static let instance = Sequence()
    
    private init() { }
    
    public func getNextValue<T>(_ obj: T) -> Int {
        
        let realmObj = obj as! Object.Type
        let realm = try! Realm()
        
        let tet = realm.objects(SequenceEntity.self).filter("name == '\(realmObj.className())'").first
        
        if tet != nil {
            if !realm.isInWriteTransaction {
                try! realm.write {
                    tet!.sequenceId = tet!.sequenceId + 1
                }
            }
            else {
                tet!.sequenceId = tet!.sequenceId + 1
            }
            
            return  tet!.sequenceId
        }
        
        let entity = SequenceEntity()
        entity.name = realmObj.className()
        entity.sequenceId = 1
        
        if !realm.isInWriteTransaction {
            try! realm.write {
                realm.add(entity)
            }
        }
        else {
            realm.add(entity)
        }
        
        return entity.sequenceId
    }
}
