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
    
    func configureContextMenu(index: Int) -> UIContextMenuConfiguration {
        let context = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            let delete = UIAction(title: "Delete",
                                  image: UIImage(systemName: "trash"),
                                  identifier: nil,
                                  discoverabilityTitle: nil,
                                  attributes: .destructive, state: .off) { (_) in
                print("delete button clicked")
                guard let itemToDelete = self.favouriteItems?[index] else {
                    print("Unable to delete item")
                    return
                }
                self.deleteItemFromDatabase(item: itemToDelete)
            }
            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [delete])
        }
        return context
    }
    
    func deleteItemFromDatabase (item: FavouriteModel) {
        let favouritesCollection = database.collection("Favourites")
        
        favouritesCollection.whereField("uid", isEqualTo: userUID).whereField("url", isEqualTo: item.url ?? "bosh")
            .getDocuments { [weak self] snapshot, error in
                if let error {
                    print("error fetching documents to delete item \(error.localizedDescription)")
                }
                
                guard let documents = snapshot?.documents else {
                    print("no documents to delete")
                    return
                }
                
                for document in documents {
                    let docRef = document.reference
                    docRef.delete { error in
                        if let error {
                            print("Got an error during deleting item \(error.localizedDescription)")
                        } else {
                            print("deleted successfully")
                            self?.favouriteItems?.removeAll(where: { $0.url == item.url })
                            self?.success?()
                        }
                    }
                }
            }
    }
    
    func reset() {
        favouriteItems?.removeAll()
    }
}
