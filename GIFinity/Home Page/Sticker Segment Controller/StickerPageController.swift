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
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewModel()
        configureCollection()
    }
    
    @objc func pullToRefresh() {
        viewmodel.reset()
        stickerCollection.reloadData()
        viewmodel.getItems()
    }
}

//MARK: Collection View Functions
extension StickerPageController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    CHTCollectionViewDelegateWaterfallLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewmodel.stickerItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollecttionCell.identifier, for: indexPath) as! ImageCollecttionCell
        if let imageURL = viewmodel.stickerItems[indexPath.item].images?.original?.url {
//            cell.gifImage.showImage(imageURL: imageURL)
            cell.configure(image: imageURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "\(SelectedItemPageController.self)") as! SelectedItemPageController
        let selectedItem = viewmodel.stickerItems[indexPath.item]
        let selectedGIF = SelectedGifModel(selectedImage: selectedItem.images?.original?.url ?? "",
                                           avatar: selectedItem.user?.avatarURL ?? "",
                                           username: selectedItem.username ?? "")
        controller.selectedItem = selectedGIF
        navigationController?.show(controller, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let height = Int(viewmodel.stickerItems[indexPath.item].images?.original?.height ?? "100"),
              let width = Int(viewmodel.stickerItems[indexPath.item].images?.original?.width ?? "100") else {
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewmodel.pagination(index: indexPath.item)
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
            self.refreshControl.endRefreshing()

        }
        viewmodel.getItems()
    }
    
    func configureCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        stickerCollection.collectionViewLayout = layout
        stickerCollection.register(ImageCollecttionCell.self,
                                   forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .red
        refreshControl.backgroundColor = .stickerCell
        stickerCollection.refreshControl = refreshControl
    }
}
