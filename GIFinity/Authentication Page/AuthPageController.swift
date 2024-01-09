//
//  AuthPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 09.01.24.
//

import UIKit

class AuthPageController: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var authSegmentOutlet: UISegmentedControl!
    @IBOutlet weak var signupSegment: UIView!
    @IBOutlet weak var loginSegment: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configSegment()
    }
    
    @IBAction func segmentSelection(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(loginSegment)
            loginSegment.isHidden = false
            signupSegment.isHidden = true
            sender.selectedSegmentTintColor = .buttonColour
        case 1:
            self.view.bringSubviewToFront(signupSegment)
            signupSegment.isHidden = false
            loginSegment.isHidden = true
            sender.selectedSegmentTintColor = .signupSelection
        default:
            break
        }
    }
    
}

extension AuthPageController {
    func configUI() {
        let backgroundGif = UIImage.gifImageWithName("background")
        background.image = backgroundGif
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func configSegment() {
        self.view.bringSubviewToFront(signupSegment)
        authSegmentOutlet.selectedSegmentIndex = 1 // kecid edende ilk bashda sign up tovsiyye etsin
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        authSegmentOutlet.setTitleTextAttributes(titleTextAttributes, for: .normal)
        signupSegment.isHidden = false
        loginSegment.isHidden = true
    }
}
