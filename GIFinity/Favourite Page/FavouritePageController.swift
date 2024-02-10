//
//  FavouritePageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import FirebaseFirestoreInternal

class FavouritePageController: UIViewController {
    
    @IBOutlet weak var favoriteCollection: UICollectionView!
    
    let layout = CHTCollectionViewWaterfallLayout()
    let userUID = CurrentUserDetect.currentUser()
    let database = Firestore.firestore()
    var favouriteItems: [FavouriteModel]? = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollection()
        getUserFavourites()
        print(userUID)
        //        print(favouriteItems ?? [FavouriteModel]())
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //        favoriteCollection.reloadData()
        print("testishkoooo \(favouriteItems!)")
        
    }
}

//MARK: Collection Functions
extension FavouritePageController: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favouriteItems?.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollecttionCell.identifier, for: indexPath) as! ImageCollecttionCell
        cell.gifImage.showImage(imageURL: favouriteItems?[indexPath.item].url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let width = Int(favouriteItems?[indexPath.item].size?.width ?? ""),
              let height = Int(favouriteItems?[indexPath.item].size?.height ?? "") else {
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: width, height: height)
    }
    
}

//MARK: Functions
extension FavouritePageController {
    func configCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        favoriteCollection.collectionViewLayout = layout
        favoriteCollection.register(ImageCollecttionCell.self, forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
    }
    
    
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
            self?.favoriteCollection.reloadData()
        }
    }
}

