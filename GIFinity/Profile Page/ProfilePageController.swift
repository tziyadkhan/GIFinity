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
    
    @IBAction func settings(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "SettingsPageController") as! SettingsPageController
        navigationController?.show(controller, sender: nil)
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
