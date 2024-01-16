//
//  HomePageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class HomePageController: UIViewController {
    
    @IBOutlet weak var iconGIF: UIImageView!
    @IBOutlet weak var gifsCollection: UICollectionView!
    
    let viewModel = HomePageViewModel()
    let layout = CHTCollectionViewWaterfallLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configUI()
        configCollection()
    }

    @IBAction func searchTextField(_ sender: Any) {
        
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
    }
    
}

extension HomePageController: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let width = Int(viewModel.trendingGifItems[indexPath.item].images?.original?.width ?? "0"),
              let height = Int(viewModel.trendingGifItems[indexPath.item].images?.original?.height ?? "0") else {
                // Handle the case where width or height is nil
                return CGSize(width: 100, height: 100) // Provide default values
            }
            
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.trendingGifItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifsCollectionCell.identifier,
                                                      for: indexPath) as! GifsCollectionCell
        if let imageURL = viewModel.trendingGifItems[indexPath.item].images?.original?.url {
            cell.gifImage.showImage(imageURL: imageURL)
            print(imageURL)
        }
        return cell
        
    }
}

extension HomePageController {
    
    func configureViewModel() {
        viewModel.error = { error in
            print(error!)
        }
        viewModel.success = {
            self.gifsCollection.reloadData()
        }
        viewModel.getItems()
    }
    func configUI() {
        let icon = UIImage.gifImageWithName("icon")
        iconGIF.image = icon
    }
    
    func configCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        gifsCollection.collectionViewLayout = layout
        gifsCollection.register(GifsCollectionCell.self, 
                                forCellWithReuseIdentifier: GifsCollectionCell.identifier)
    }
}

