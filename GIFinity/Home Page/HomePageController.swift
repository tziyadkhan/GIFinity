//
//  HomePageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import UIKit

class HomePageController: UIViewController {
    
    @IBOutlet weak var iconGIF: UIImageView!
    @IBOutlet weak var categorySegmentOutlet: UISegmentedControl!
    @IBOutlet weak var stickerSegment: UIView!
    @IBOutlet weak var trendingSegment: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSegment()
        configUI()
    }
    
    @IBAction func categorySelection(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(trendingSegment)
            trendingSegment.isHidden = false
            stickerSegment.isHidden = true
            sender.selectedSegmentTintColor = .trendingCell
        case 1:
            self.view.bringSubviewToFront(stickerSegment)
            trendingSegment.isHidden = true
            stickerSegment.isHidden = false
            sender.selectedSegmentTintColor = .stickerCell
        default:
            break
        }
    }
    
    @IBAction func searchTextField(_ sender: Any) {
        
    }
    
    @IBAction func searchButton(_ sender: Any) {
        
    }
    
}
extension HomePageController {
    func configSegment() {
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 13, weight: .semibold)]
        categorySegmentOutlet.setTitleTextAttributes(titleTextAttributes, for: .normal)
    }
    func configUI() {
        let icon = UIImage.gifImageWithName("icon")
        iconGIF.image = icon
    }
}
