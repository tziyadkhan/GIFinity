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
    
    let viewModel = TrendingPageViewModel()
    let layout = CHTCollectionViewWaterfallLayout()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureViewModel()
    }
    
    @objc func pullToRefresh() {
        viewModel.reset()
        trendingCollection.reloadData()
        viewModel.getItems()
    }
}

//MARK: Collection View Functions
extension TrendingPageController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.trendingGifItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollecttionCell.identifier, for: indexPath) as! ImageCollecttionCell
        if let imageURL = viewModel.trendingGifItems[indexPath.item].images?.original?.url {
            cell.gifImage.showImage(imageURL: imageURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let width = Int(viewModel.trendingGifItems[indexPath.item].images?.original?.width ?? "100"),
              let height = Int(viewModel.trendingGifItems[indexPath.item].images?.original?.height ?? "100") else {
                return CGSize(width: 100, height: 100)
            }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.pagination(index: indexPath.item)
//        print("\(indexPath.item)")
    }
}

//MARK: Functions
extension TrendingPageController {
    func configureViewModel() {
        viewModel.error = { error in
            print(error!)
        }
        viewModel.success = {
            self.trendingCollection.reloadData()
            self.refreshControl.endRefreshing()

        }
        viewModel.getItems()
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
}
