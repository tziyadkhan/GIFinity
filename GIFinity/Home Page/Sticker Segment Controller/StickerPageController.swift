//
//  StickerPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 19.01.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class StickerPageController: UIViewController {

    @IBOutlet weak var stickerCollection: UICollectionView!
    
    let viewmodel = StickerPageViewModel()
    let layout = CHTCollectionViewWaterfallLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureCollection()
    }
}

//MARK: Collection View Functions
extension StickerPageController: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewmodel.stickerItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollecttionCell.identifier, for: indexPath) as! ImageCollecttionCell
        if let imageURL = viewmodel.stickerItems[indexPath.item].images?.original?.url {
            cell.gifImage.showImage(imageURL: imageURL)
            print(imageURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let height = Int(viewmodel.stickerItems[indexPath.item].images?.original?.height ?? "100"),
              let width = Int(viewmodel.stickerItems[indexPath.item].images?.original?.width ?? "100") else {
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: width, height: height)
    }
}

//MARK: Functions
extension StickerPageController {
    func configureViewModel() {
        viewmodel.error = { error in
            print(error!)
        }
        viewmodel.success = {
            self.stickerCollection.reloadData()
        }
        viewmodel.getItems()
    }
    
    func configureCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        stickerCollection.collectionViewLayout = layout
        stickerCollection.register(ImageCollecttionCell.self,
                                   forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
    }
}
