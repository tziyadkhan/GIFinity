//
//  RegisterSegmentController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 09.01.24.
//

import UIKit

class RegisterSegmentController: UIViewController {

    @IBOutlet weak var regEmailTextField: UITextField!
    @IBOutlet weak var regUsernameTextField: UITextField!
    @IBOutlet weak var regPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signupButton(_ sender: Any) {
    }
    
    @IBAction func alreadyStartedRegButton(_ sender: Any) {
    }
    
    @IBAction func signinFacebook(_ sender: Any) {
    }
    
    @IBAction func signinApple(_ sender: Any) {
    }
    
    @IBAction func termsOfService(_ sender: Any) {
        if let url = URL(string: "https://support.giphy.com/hc/en-us/articles/360020027752-GIPHY-User-Terms-of-Service#:~:text=Please%20do%20not%20publicly%20post,in%20connection%20with%20its%20Services.") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func privacyPolicy(_ sender: Any) {
        if let url = URL(string: "https://support.giphy.com/hc/en-us/articles/360032872931") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func googlePrivacy(_ sender: Any) {
        if let url = URL(string: "https://policies.google.com/privacy?hl=en-US") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func tickButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
}


//safari window saytlar ucun

