//
//  TrendingPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 19.01.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class TrendingPageController: UIViewController {
    
    @IBOutlet weak var trendingCollection: UICollectionView!
    
    private let viewmodel = TrendingPageViewModel()
    private let layout = CHTCollectionViewWaterfallLayout()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureViewModel()
    }
    
    @objc func pullToRefresh() {
        viewmodel.reset()
        trendingCollection.reloadData()
        viewmodel.getItems()
    }
}

//MARK: Collection View Functions
extension TrendingPageController: UICollectionViewDelegate,
                                  UICollectionViewDataSource,
                                  CHTCollectionViewDelegateWaterfallLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewmodel.trendingGifItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollecttionCell.identifier, for: indexPath) as! ImageCollecttionCell
        if let imageURL = viewmodel.trendingGifItems[indexPath.item].images?.original?.url {
            cell.configure(image: imageURL)
        }
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = viewmodel.trendingGifItems[indexPath.item]
        let selectedGIF = SelectedGifModel(selectedImage: selectedItem.images?.original?.url ?? "",
                                           avatar: selectedItem.user?.avatarURL ?? "",
                                           username: selectedItem.username ?? "",
                                           imageWidth: selectedItem.images?.original?.width,
                                           imageHeight: selectedItem.images?.original?.height)
        showSelectedItem(item: selectedGIF)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let width = Int(viewmodel.trendingGifItems[indexPath.item].images?.original?.width ?? "100"),
              let height = Int(viewmodel.trendingGifItems[indexPath.item].images?.original?.height ?? "100") else {
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewmodel.pagination(index: indexPath.item)
    }
}

//MARK: Functions
extension TrendingPageController {
    
    func configureViewModel() {
        viewmodel.error = { error in
        }
        viewmodel.success = {
            self.trendingCollection.reloadData()
            self.refreshControl.endRefreshing()
        }
        viewmodel.getItems()
    }
    
    func configureCollectionView() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        trendingCollection.collectionViewLayout = layout
        trendingCollection.register(ImageCollecttionCell.self, forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged) 
        refreshControl.tintColor = .red
        refreshControl.backgroundColor = .trendingCell
        trendingCollection.refreshControl = refreshControl
    }
    
    func showSelectedItem(item: SelectedGifModel) {
        let coordinator = SelectedItemCoordinator(navigationController: navigationController ?? UINavigationController())
        coordinator.start(item: item)
    }
}
