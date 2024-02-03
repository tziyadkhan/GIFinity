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
    
    let layout = CHTCollectionViewWaterfallLayout()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()   
        // Do any additional setup after loading the view.
    }
    
    @IBAction func favouriteButton(_ sender: Any) {
    }
    
    
    @IBAction func downloadButton(_ sender: Any) {
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
        cell.configure(image: "purple")
        return cell
    }
    
    
}

//MARK:
extension SelectedItemPageController {
    func configureCollection() {
        layout.columnCount = 2
        layout.itemRenderDirection = .leftToRight
        relatedGIFCollection.collectionViewLayout = layout
        relatedGIFCollection.register(ImageCollecttionCell.self, forCellWithReuseIdentifier: ImageCollecttionCell.identifier)
    }
}
