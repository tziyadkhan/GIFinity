//
//  SearchPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 05.02.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout

class SearchPageController: UIViewController {

    @IBOutlet weak var iconGif: UIImageView!
    @IBOutlet weak var searchCollection: UICollectionView!
    
    private let layout = CHTCollectionViewWaterfallLayout()
    private let viewmodel = SearchPageViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollection()
        configUI()
        touchGesture()
    }

    @IBAction func searchTextField(_ sender: UITextField) {
        if let text = sender.text {
            print(text)
            viewmodel.getSearchItem(searchText: text) {
                self.searchCollection.reloadData()
                self.view.endEditing(true)
                sender.resignFirstResponder()
            }
        } else {
            viewmodel.clearItems()
            searchCollection.reloadData()
        }
    }
}

//MARK: Collection Functions
extension SearchPageController: UICollectionViewDelegate,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewmodel.searchedGifItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollecttionCell.identifier, for: indexPath) as! ImageCollecttionCell
        if let imageURL = viewmodel.searchedGifItem[indexPath.item].images?.original?.url {
            cell.configure(image: imageURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = viewmodel.searchedGifItem[indexPath.item]
        let selectedGIF = SelectedGifModel(
            selectedImage: selectedItem.images?.original?.url ?? "",
            avatar: selectedItem.user?.avatarURL ?? "",
            username: selectedItem.username ?? ""
        )
        showSelectedItem(item: selectedGIF)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let width = Int(viewmodel.searchedGifItem[indexPath.item].images?.original?.width ?? "100"),
              let height = Int(viewmodel.searchedGifItem[indexPath.item].images?.original?.height ?? "100") else {
            return CGSize(width: 100, height: 100)
        }
        return CGSize(width: width, height: height)
    }
}

//MARK: Functions
extension SearchPageController {
    
    func configureCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        searchCollection.collectionViewLayout = layout
        searchCollection.register(ImageCollecttionCell.self, forCellWithReuseIdentifier: "\(ImageCollecttionCell.identifier)")
    }
    
    func configUI() {
        let icon = UIImage.gifImageWithName("icon")
        iconGif.image = icon
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func touchGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                tapGesture.cancelsTouchesInView = false
                view.addGestureRecognizer(tapGesture)
    }
    
    func showSelectedItem(item: SelectedGifModel) {
        let coordinator = SelectedItemCoordinator(navigationController: navigationController ?? UINavigationController())
        coordinator.start(item: item)
    }
}
