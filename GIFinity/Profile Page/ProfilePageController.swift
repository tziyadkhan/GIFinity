//
//  ProfilePageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import UIKit
import FirebaseFirestoreInternal
import CHTCollectionViewWaterfallLayout

class ProfilePageController: UIViewController {
    
    @IBOutlet weak var favouriteCollection: UICollectionView!
    @IBOutlet weak var profileBackgroundGif: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullnameLabelText: UILabel!
    
    let userUID = CurrentUserDetect.currentUser()
    let database = Firestore.firestore()
    let layout = CHTCollectionViewWaterfallLayout()
    var favouriteItems: [FavouriteModel]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getUserInfo()
        configCollection()
        getUserFavourites()
        print(userUID)
    }
    
    @IBAction func exit(_ sender: Any) {
        showAlert(title: "Warning", message: "Are you sure you want to exit?")
    }
    
}

//MARK: Mini Favourite Collection
extension ProfilePageController: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
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
extension ProfilePageController {
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(false, forKey: "loggedIN") // Setting the flag
            sceneDelegate.loginPage(window: scene)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okaybutton = UIAlertAction(title: "Log out", style: .default) { (_) in
            self.setRoot()
        }
        let cancelButton = UIAlertAction(title: "Stay", style: .cancel)
        
        alertController.addAction(okaybutton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    func configUI() {
        let profileBackground = UIImage.gifImageWithName("profileBackgroundGIF")
        profileBackgroundGif.image = profileBackground
        
        let profile = UIImage.gifImageWithName("profileGIF")
        profileImage.image = profile
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
                    self.fullnameLabelText.text = item.fullname
                }
            }
        }
    }
    
    
    func configCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        favouriteCollection.collectionViewLayout = layout
        favouriteCollection.register(ImageCollecttionCell.self, forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
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
            self?.favouriteCollection.reloadData()
        }
    }
}
