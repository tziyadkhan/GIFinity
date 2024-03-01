//
//  SelectedItemPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 03.02.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import Photos

class SelectedItemPageController: UIViewController {
    
    @IBOutlet weak var selectedGIFImageView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var relatedGIFCollection: UICollectionView!
    
    var selectedItem: SelectedGifModel?
    private let layout = CHTCollectionViewWaterfallLayout()
    private let viewmodel = SelectedItemViewModel()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollection()
        fillItems()
        configureViewModel()
    }
    
   
    
    @IBAction func favouriteButton(_ sender: Any) {
        viewmodel.addItems(data: selectedItem!)
        AlertView.showAlert(view: self, title: "Success", message: "Successfully aded")
        
    }
    
    @IBAction func saveGIF(_ sender: Any) {
        saveGIF()
    }
    @IBAction func shareButton(_ sender: Any) {
        shareButton()
    }
    
}

//MARK: Other GIFs Collection Functions
extension SelectedItemPageController: UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout {
    
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
                                           username: selectedItem.username ?? "")
        showSelectedItem(item: selectedGIF)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let width = Int(viewmodel.trendingGifItems[indexPath.item].images?.original?.width ?? "100"),
              let height = Int(viewmodel.trendingGifItems[indexPath.item].images?.original?.height ?? "100") else {
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: width, height: height)
    }
}

//MARK: Functions
extension SelectedItemPageController {
    
    @objc func pullToRefresh() {
        viewmodel.reset()
        relatedGIFCollection.reloadData()
        viewmodel.getItems()
    }
    
    func configureCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        relatedGIFCollection.collectionViewLayout = layout
        relatedGIFCollection.register(ImageCollecttionCell.self, forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        refreshControl.tintColor = .red
        refreshControl.backgroundColor = .trendingCell
        relatedGIFCollection.refreshControl = refreshControl
    }
    
    func fillItems() {
        selectedGIFImageView.showImage(imageURL: selectedItem?.selectedImage)
        profileImage.showImage(imageURL: selectedItem?.avatar)
        profileNameLabel.text = selectedItem?.username
    }
    
    
    func saveGIF() {
        if let gifData = try? Data(contentsOf: URL(string: self.selectedItem?.selectedImage ?? "")!) {
            self.viewmodel.saveGifToPhotosHelper(gifData: gifData)
            AlertView.showAlert(view: self, title: "Saved", message: "Your GIF has been saved to your photos")
        } else {
            AlertView.showAlert(view: self, title: "Error", message: "Failed to save GIF")
        }
    }
    
    func shareButton() {
        guard let image = selectedGIFImageView.image,
              let url = selectedItem?.selectedImage else {return}
        let shareSheetVC = UIActivityViewController (activityItems: [image, url],
                                                     applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
    
    func configureViewModel() {
        viewmodel.error = { error in
            print(error!)
        }
        viewmodel.success = {
            self.relatedGIFCollection.reloadData()
            self.refreshControl.endRefreshing()
        }
        viewmodel.getItems()
    }
    
    func showSelectedItem(item: SelectedGifModel) {
        let coordinator = SelectedItemCoordinator(navigationController: navigationController ?? UINavigationController())
        coordinator.start(item: item)
    }
}

