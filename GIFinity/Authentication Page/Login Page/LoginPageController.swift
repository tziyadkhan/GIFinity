//
//  LoginPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 01.02.24.
//

import UIKit
import FirebaseAuth

class LoginPageController: UIViewController {
    
    @IBOutlet weak var backgroundGIF: UIImageView!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if let email = loginEmailTextField.text,
           let password = loginPasswordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error {
                    self.showAlert(title: "Error", message: error.localizedDescription)
                } else if let _ = result?.user {
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "\(HomePageController.self)") as! HomePageController
                    self.navigationController?.show(controller, sender: true)
                }
            }
        }
    }
    // Root controller duzeldenden sonra, TabBarControllere cevir
    
    @IBAction func signupButton(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegistrationPageController") as! RegistrationPageController
        controller.onLogin = { [weak self] email, password in
            self?.loginEmailTextField.text = email
            self?.loginPasswordTextField.text = password
        }
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
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
}
