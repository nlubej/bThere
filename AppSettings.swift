//
//  File.swift
//  bThere
//
//  Created by Nejc Lubej on 24/06/2017.
//  Copyright © 2017 Nejc Lubej. All rights reserved.
//

import Foundation

struct AppSettings {
    private static var _currentUser : User?
    
    public static var currentUser : User! {
        get {
            if _currentUser != nil {
                return _currentUser!;
            }
            else {
                let dataModel = DataModel()
                _currentUser = dataModel.getCurrentUser()
                return _currentUser
            }
        }
    }
    
    public static var useCustomBackground = true
}
