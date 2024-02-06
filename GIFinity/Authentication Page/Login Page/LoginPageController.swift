//
//  LoginPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 01.02.24.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LoginPageController: UIViewController {
    
    @IBOutlet weak var backgroundGIF: UIImageView!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    @IBOutlet weak var loginEmailTextField: UITextField!
    
    var adapter: LoginAdapter?
    let database = DatabaseAdapter()
    let urlHelper = URLs()
    var userEmail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        adapter = LoginAdapter(controller: self)

    }
    override func viewDidDisappear(_ animated: Bool) {
        print(userEmail ?? "bosh email")
    }
    @IBAction func loginButton(_ sender: Any) {
        loginCheck()
    }
    
    @IBAction func signupButton(_ sender: Any) {
        signUP()
    }
    
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        
    }
    
    @IBAction func termsOfService(_ sender: Any) {
        urlHelper.callURL(urlType: .termsOfService)
    }
    
    @IBAction func privacyPolicy(_ sender: Any) {
        urlHelper.callURL(urlType: .privacyTerms)
        
    }
}

//MARK: Functions
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
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.set(true, forKey: "loggedIN")
            sceneDelegate.homePage(window: scene)
        }
    }
    
    func loginCheck() {
        if let email = loginEmailTextField.text,
           let password = loginPasswordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error {
                    self.showAlert(title: "Error", message: error.localizedDescription)
                } else if let _ = result?.user {
                    self.userEmail = result?.user.email ?? "bosh email"
                    self.setRoot()
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "\(TabBarController.self)") as! TabBarController
                    self.navigationController?.show(controller, sender: true)
                }
            }
        }
    }
    
    func signUP() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "RegistrationPageController") as! RegistrationPageController
        controller.onLogin = { [weak self] email, password in
            self?.loginEmailTextField.text = email
            self?.loginPasswordTextField.text = password
        }
        navigationController?.show(controller, sender: nil)
    }
    
}
