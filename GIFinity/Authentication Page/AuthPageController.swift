//
//  AuthPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 09.01.24.
//

import UIKit

class AuthPageController: UIViewController {
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()

        // Do any additional setup after loading the view.
    }
  
}

extension AuthPageController {
    func configUI() {
        let backgroundGif = UIImage.gifImageWithName("background")
        background.image = backgroundGif
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
