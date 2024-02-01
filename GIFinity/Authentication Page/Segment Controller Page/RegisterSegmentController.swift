//
//  RegisterSegmentController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 09.01.24.
//

import UIKit

class RegisterSegmentController: UIViewController {

    @IBOutlet weak var regEmailTextField: UITextField!
    @IBOutlet weak var regFullnameTextField: UITextField!
    @IBOutlet weak var regPasswordTextField: UITextField!
    
    var onLogin: ((String?, String?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signupButton(_ sender: Any) {
        register()
        print("test")
    }
    
    @IBAction func alreadyStartedRegButton(_ sender: Any) {
        
    }
    
    @IBAction func signInGoogle(_ sender: Any) {
        
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

extension RegisterSegmentController {
    func register() {
        let user = Profile(fullname: regFullnameTextField.text ?? "",
                           email: regEmailTextField.text ?? "",
                           password: regPasswordTextField.text ?? "")
        onLogin?(regEmailTextField.text, regPasswordTextField.text)
        navigationController?.popViewController(animated: true)
    }
}
//safari window saytlar ucun

