//
//  SettingsPageViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 14.02.24.
//

import Foundation
import FirebaseFirestoreInternal

class SettingsPageViewModel {
    
    let userUID = CurrentUserDetect.currentUser()
    let database = Firestore.firestore()
    var successFullname: ((String) -> Void)?
    
    func getUserInfo() {
        let userInfoCollection = database.collection("UserInfo")
        userInfoCollection.whereField("uid", isEqualTo: userUID).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("no documents")
                return
            }
            
            for document in documents {
                let dict = document.data()
                if let data = try? JSONSerialization.data(withJSONObject: dict),
                   let item = try? JSONDecoder().decode(UserProfile.self, from: data) {
                    self.successFullname?(item.fullname ?? "bosh")
                }
            }
        }
    }
}
