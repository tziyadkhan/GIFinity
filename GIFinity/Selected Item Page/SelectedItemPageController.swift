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
    let layout = CHTCollectionViewWaterfallLayout()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        fillItems()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func favouriteButton(_ sender: Any) {
        
    }
    
    @IBAction func saveGIF(_ sender: Any) {
//        DispatchQueue.main.async {
            if let gifData = try? Data(contentsOf: URL(string: self.selectedItem?.selectedImage ?? "")!) {
                self.saveGifToPhotosLibrary(gifData: gifData)
                self.showAlert(title: "Saved", message: "Your GIF has been saved to your photos")
            } else {
                self.showAlert(title: "Error", message: "Failed to save GIF")
            }
//        }
        
    }
    @IBAction func shareButton(_ sender: Any) {
        shareButton()
    }
    
}

extension SelectedItemPageController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollecttionCell.identifier, for: indexPath) as! ImageCollecttionCell
        return cell
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
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let okayButton = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okayButton)
        present(alertController, animated: true)
    }
    
    func saveGifToPhotosLibrary(gifData: Data) {
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
    
    func shareButton() {
        guard let image = selectedGIFImageView.image,
              let url = selectedItem?.selectedImage else {return}
        
        let shareSheetVC = UIActivityViewController (activityItems: [image, url],
                                                     applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
}

