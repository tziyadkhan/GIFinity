//
//  CurrentUserDetect.swift
//  GIFinity
//
//  Created by Ziyadkhan on 09.02.24.
//

import Foundation
import Firebase

class CurrentUserDetect {
    static func currentUser() -> String {
        guard let currentUser = Auth.auth().currentUser else {return "bosh"}
        let userUID = currentUser.uid
        return userUID
    }
}
