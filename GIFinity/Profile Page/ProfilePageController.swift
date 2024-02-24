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

    private let layout = CHTCollectionViewWaterfallLayout()
    private let viewmodel = ProfilePageViewModel()
    private let refreshControl = UIRefreshControl()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configCollection()
        configViewModel()
        
    }
    
    @objc func pullToRefresh() {
        viewmodel.reset()
        favouriteCollection.reloadData()
        viewmodel.getUserFavourites()
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
        if let imageURL = viewmodel.favouriteItems?[indexPath.item].url{
            cell.configure(image: imageURL)
        }
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
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .red
        refreshControl.backgroundColor = .trendingCell
        favouriteCollection.refreshControl = refreshControl
    }
    
    func configViewModel() {
        
        viewmodel.success = {
            self.favouriteCollection.reloadData()
            self.refreshControl.endRefreshing()
        }
        
        viewmodel.successFullname = { name in
            self.fullnameLabelText.text = name
        }
        
        viewmodel.getUserFavourites()
        viewmodel.getUserInfo()
    }
    
}
