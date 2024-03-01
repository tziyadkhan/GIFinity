//
//  ProfilePageViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation
import FirebaseFirestoreInternal

class ProfilePageViewModel {
    
    let userUID = CurrentUserDetect.currentUser()
    let database = Firestore.firestore()
    var favouriteItems: [FavouriteModel]? = []
    var success: (() -> Void)?
    var successFullname: ((String) -> Void)?
    
    func getUserFavourites() {
        let favouritesCollection = database.collection("Favourites")
        favouritesCollection.whereField("uid", isEqualTo: userUID).addSnapshotListener { [weak self] snapshot, error in
            if let error = error {
                print("Error fetching favourites: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No favourites found.")
                return
            }
            
            var favourites = [FavouriteModel]()
            for document in documents {
                let dict = document.data()
                
                if let jsonData = try? JSONSerialization.data(withJSONObject: dict),
                   let item = try? JSONDecoder().decode(FavouriteModel.self, from: jsonData) {
                    favourites.append(item)
                }
            }
            self?.favouriteItems = favourites
            print("Favourites updated: \(favourites)")
            self?.success?()
        }
    }
    
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
    
    func reset() {
        favouriteItems?.removeAll()
    }
}
