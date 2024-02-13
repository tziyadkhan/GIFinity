//
//  FavouritePageViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation
import FirebaseFirestoreInternal

class FavouritePageViewModel {
    
    let userUID = CurrentUserDetect.currentUser()
    let database = Firestore.firestore()
    var favouriteItems: [FavouriteModel]? = []
    var success: (() -> Void)?

    
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
            self?.success?()
            print("Favourites updated: \(favourites)")
        }
    }
}
