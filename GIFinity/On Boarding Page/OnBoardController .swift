//
//  OnBoardController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 06.01.24.
//

import UIKit

class OnBoardController: UIViewController {
    
    @IBOutlet weak var centralGIF: UIImageView!
    @IBOutlet weak var backgroundGIF: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
       configUI()
    }
    
    @IBAction func getStartedButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "AuthPageController") as! AuthPageController
        navigationController?.show(controller, sender: nil)
    }
    
}

//MARK: Functions
extension OnBoardController {
    func configUI() {
        let backgroundGif = UIImage.gifImageWithName("background")
        backgroundGIF.image = backgroundGif
        let centralGif = UIImage.gifImageWithName("centralGif")
        centralGIF.image = centralGif
        
    }
}
