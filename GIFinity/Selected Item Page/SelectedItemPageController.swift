//
//  SelectedItemPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 03.02.24.
//

import UIKit
import CHTCollectionViewWaterfallLayout

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
        guard let image = selectedGIFImageView.image else {return}
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: image)
    }
    
    
    @IBAction func shareButton(_ sender: Any) {
        
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
}

