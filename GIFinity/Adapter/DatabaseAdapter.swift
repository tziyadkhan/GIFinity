//
//  DatabaseAdapter.swift
//  GIFinity
//
//  Created by Ziyadkhan on 02.02.24.
//

import Foundation
class DatabaseAdapter {
    
    func saveUser(user: UserProfile) {
        UserDefaults.standard.set(user.fullname, forKey: "fullname")
        UserDefaults.standard.set(user.email, forKey: "email")
    }
}
