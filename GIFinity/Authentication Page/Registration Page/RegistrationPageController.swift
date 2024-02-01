//
//  RegistrationPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 01.02.24.
//

import UIKit

class RegistrationPageController: UIViewController {
    
    @IBOutlet weak var backgroundGIF: UIImageView!
    @IBOutlet weak var regFullnameTextField: UITextField!
    @IBOutlet weak var regEmailTextField: UITextField!
    @IBOutlet weak var regPasswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    @IBAction func signupButton(_ sender: Any) {
        
    }
    
    @IBAction func haveAccountButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LoginPageController") as! LoginPageController
        navigationController?.show(controller, sender: nil)
    }
    
    @IBAction func signWithGoogle(_ sender: Any) {
        
    }
    
    
    @IBAction func privacyTerms(_ sender: Any) {
        if let url = URL(string: "https://policies.google.com/privacy?hl=en-US") {
            UIApplication.shared.open(url)
        }
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
    
    @IBAction func tickButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
}

//MARK: Functions
extension RegistrationPageController {
    func configUI() {
        let backgroundGif = UIImage.gifImageWithName("background")
        backgroundGIF.image = backgroundGif
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
