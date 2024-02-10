//
//  SelectedItemPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 03.02.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout
import Photos
import FirebaseFirestoreInternal


class SelectedItemPageController: UIViewController {
    
    @IBOutlet weak var selectedGIFImageView: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var relatedGIFCollection: UICollectionView!
    
    var selectedItem: SelectedGifModel?
    let layout = CHTCollectionViewWaterfallLayout()
    let viewmodel = SelectedItemViewModel()
    let database = Firestore.firestore()
    let userUID = CurrentUserDetect.currentUser()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        fillItems()
        configureViewModel()
        print("testtttttt \(selectedItem!)")
    }
    
    @IBAction func favouriteButton(_ sender: Any) {
        addItems()
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
            cell.gifImage.showImage(imageURL: imageURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "\(SelectedItemPageController.self)") as! SelectedItemPageController
        let selectedItem = viewmodel.trendingGifItems[indexPath.item]
        let selectedGIF = SelectedGifModel(selectedImage: selectedItem.images?.original?.url ?? "",
                                           avatar: selectedItem.user?.avatarURL ?? "",
                                           username: selectedItem.username ?? "")
        controller.selectedItem = selectedGIF
        navigationController?.show(controller, sender: nil)
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
    
    func configureCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        relatedGIFCollection.collectionViewLayout = layout
        relatedGIFCollection.register(ImageCollecttionCell.self, forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
    }
    
    func fillItems() {
        selectedGIFImageView.showImage(imageURL: selectedItem?.selectedImage)
        profileImage.showImage(imageURL: selectedItem?.avatar)
        profileNameLabel.text = selectedItem?.username
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okayButton)
        present(alertController, animated: true)
    }
    
    func saveGifToPhotosHelper(gifData: Data) {
        PHPhotoLibrary.shared().performChanges {
            let creationRequest = PHAssetCreationRequest.forAsset()
            creationRequest.addResource(with: .photo, data: gifData, options: nil)
        } completionHandler: { success, error in
            if success {
                print("GIF saved successfully.")
            } else if let error = error {
                print("Error saving GIF: \(error.localizedDescription)")
            }
        }
    }
    
    func saveGIF() {
        //        DispatchQueue.main.async {
        if let gifData = try? Data(contentsOf: URL(string: self.selectedItem?.selectedImage ?? "")!) {
            self.saveGifToPhotosHelper(gifData: gifData)
            self.showAlert(title: "Saved", message: "Your GIF has been saved to your photos")
        } else {
            self.showAlert(title: "Error", message: "Failed to save GIF")
        }
        //        }
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
//            print(self.viewmodel.trendingGifItems)
        }
        viewmodel.getItems()
    }
    
    func addItems() {
        let data = ["url" : "\(selectedItem?.selectedImage ?? "bosh url")",
                    "uid" : "\(userUID)",
                    "imageWidth" : "\(selectedItem?.imageWidth ?? "100")",
                    "imageHeight" : "\(selectedItem?.imageHeight ?? "100")"]
        print(data)
        database.collection("Favourites").addDocument(data: data)
        showAlert(title: "Success", message: "Successfully added")
    }
}

