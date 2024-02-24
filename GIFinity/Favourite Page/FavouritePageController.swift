//
//  FavouritePageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class FavouritePageController: UIViewController {
    
    @IBOutlet weak var favoriteCollection: UICollectionView!
    
    private let layout = CHTCollectionViewWaterfallLayout()
    private let viewmodel = FavouritePageViewModel()
    private let refreshControl = UIRefreshControl()   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollection()
        configViewmodel()
        configUI()
    }
    
    @objc func pullToRefresh() {
        viewmodel.reset()
        favoriteCollection.reloadData()
        viewmodel.getUserFavourites()
    }
}

//MARK: Collection Functions
extension FavouritePageController: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    
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
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        viewmodel.configureContextMenu(index: indexPath.row)
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
    
    func configUI() {
        title = "Favourites"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func configCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        favoriteCollection.collectionViewLayout = layout
        favoriteCollection.register(ImageCollecttionCell.self, forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .red
        refreshControl.backgroundColor = .trendingCell
        favoriteCollection.refreshControl = refreshControl
    }
    
    func configViewmodel() {
        viewmodel.success = {
            self.favoriteCollection.reloadData()
            self.refreshControl.endRefreshing()
        }
        viewmodel.getUserFavourites()
    }
}


