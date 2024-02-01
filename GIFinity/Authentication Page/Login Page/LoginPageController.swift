//
//  LoginPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 01.02.24.
//

import UIKit

class LoginPageController: UIViewController {

    @IBOutlet weak var backgroundGIF: UIImageView!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
    }
    
    @IBAction func signupButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegistrationPageController") as! RegistrationPageController
        navigationController?.show(controller, sender: nil)
    }
    
    @IBAction func signWithGoogleButton(_ sender: Any) {
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
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
    
}

extension LoginPageController {
    func configUI() {
        let backgroundGif = UIImage.gifImageWithName("background")
        backgroundGIF.image = backgroundGif
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
}
