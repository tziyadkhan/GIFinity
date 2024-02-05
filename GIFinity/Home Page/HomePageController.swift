//
//  HomePageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import UIKit

class HomePageController: UIViewController {
    
    @IBOutlet weak var categorySegmentOutlet: UISegmentedControl!
    @IBOutlet weak var stickerSegment: UIView!
    @IBOutlet weak var trendingSegment: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSegment()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "\(SearchPageController.self)") as! SearchPageController
        navigationController?.show(controller, sender: nil)
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
    

    
}
extension HomePageController {
    func configSegment() {
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 13, weight: .semibold)]
        categorySegmentOutlet.setTitleTextAttributes(titleTextAttributes, for: .normal)
    }
    
}
