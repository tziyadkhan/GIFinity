//
//  ProfilePageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class ProfilePageController: UIViewController {
    
    @IBOutlet weak var favouriteCollection: UICollectionView!
    @IBOutlet weak var profileBackgroundGif: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullnameLabelText: UILabel!

    let layout = CHTCollectionViewWaterfallLayout()
    let viewmodel = ProfilePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configCollection()
        configViewModel()
        
    }
    
    @IBAction func exit(_ sender: Any) {
        showAlert(title: "Warning", message: "Are you sure you want to exit?")
    }
}

//MARK: Mini Favourite Collection
extension ProfilePageController: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewmodel.favouriteItems?.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollecttionCell.identifier, for: indexPath) as! ImageCollecttionCell
        cell.gifImage.showImage(imageURL: viewmodel.favouriteItems?[indexPath.item].url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let width = Int(viewmodel.favouriteItems?[indexPath.item].size?.width ?? ""),
              let height = Int(viewmodel.favouriteItems?[indexPath.item].size?.height ?? "") else {
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
    
    func configCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        favouriteCollection.collectionViewLayout = layout
        favouriteCollection.register(ImageCollecttionCell.self, forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
    }
    
    func configViewModel() {
        
        viewmodel.success = {
            self.favouriteCollection.reloadData()
        }
        
        viewmodel.successFullname = { name in
            self.fullnameLabelText.text = name
        }
        
        viewmodel.getUserFavourites()
        viewmodel.getUserInfo()
    }
}
