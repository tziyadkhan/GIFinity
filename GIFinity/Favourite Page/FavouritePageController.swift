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
    let viewmodel = FavouritePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollection()
        configViewmodel()
    }
}

//MARK: Collection Functions
extension FavouritePageController: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
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
extension FavouritePageController {
    func configCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        favoriteCollection.collectionViewLayout = layout
        favoriteCollection.register(ImageCollecttionCell.self, forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
    }
    
    func configViewmodel() {
        
        viewmodel.success = {
            self.favoriteCollection.reloadData()
        }
        viewmodel.getUserFavourites()
    }
}

