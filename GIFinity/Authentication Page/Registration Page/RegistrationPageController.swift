//
//  RegistrationPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 01.02.24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class RegistrationPageController: UIViewController {
    
    @IBOutlet weak var backgroundGIF: UIImageView!
    @IBOutlet weak var regFullnameTextField: UITextField!
    @IBOutlet weak var regEmailTextField: UITextField!
    @IBOutlet weak var regPasswordTextField: UITextField!
    
    var adapter: LoginAdapter?
    var tickValidation = false
    let urlHelper = URLs()
    let database = Firestore.firestore()
    var onLogin: ((String, String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        googleSignIn()
    }
    
    @IBAction func signupButton(_ sender: Any) {
        if tickValidation {
            signUP()
        } else {
            showAlert(title: "Error", message: "Please agree with Terms & Conditions")
        }
        
    }
    
    @IBAction func haveAccountButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        adapter?.login(loginType: .google)
    }
    
    
    @IBAction func googlePrivacy(_ sender: Any) {
        urlHelper.callURL(urlType: .googlePrivacyTerms)

    }
    
    @IBAction func termsOfService(_ sender: Any) {
        urlHelper.callURL(urlType: .termsOfService)

    }
    
    @IBAction func privacyPolicy(_ sender: Any) {
        urlHelper.callURL(urlType: .privacyTerms)

    }
    
    @IBAction func tickButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            tickValidation = false
        } else {
            sender.isSelected = true
            tickValidation = true
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
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okayButton)
        self.present(alertController, animated: true)
    }
    
    func signUP() {
        if let fullname = regFullnameTextField.text,
           let email = regEmailTextField.text,
           let password = regPasswordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                if let error {
                    self?.showAlert(title: "Error", message: error.localizedDescription)
                } else if let _ = result?.user {
                    let user = UserProfile(fullname: fullname, email: email, password: "")
                    self?.onLogin?(user.email ?? "", password)
                    let data = ["email": "\(email)", "fullname" : "\(fullname)", "uid": "\(result?.user.uid ?? "bosh")"]
                    self?.database.collection("UserInfo").addDocument(data: data)
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
// Google vasitesi ile sign in edende, user-in adini ve emailini avtomatik textfield-de doldurur
    func googleSignIn() {
        adapter = LoginAdapter(controller: self)
        adapter?.userCompletion = { user in
            self.regFullnameTextField.text = user.fullname ?? ""
            self.regEmailTextField.text = user.email ?? ""
        }
    }
}
