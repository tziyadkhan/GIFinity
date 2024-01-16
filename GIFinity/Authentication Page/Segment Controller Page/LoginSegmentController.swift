//
//  LoginSegmentController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 09.01.24.
//

import UIKit

class LoginSegmentController: UIViewController {

    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var loginPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        navigationController?.show(controller, sender: nil)
        
        // root controllerden sonra duzelecek 
    }
    
    @IBAction func forgotPassButton(_ sender: Any) {
        
    }
    
    @IBAction func signinFacebook(_ sender: Any) {
    }
    
    @IBAction func signinApple(_ sender: Any) {
    }
    
    @IBAction func privacyAndPolicy(_ sender: Any) {
        if let url = URL(string: "https://support.giphy.com/hc/en-us/articles/360032872931") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func termsOfService(_ sender: Any) {
        if let url = URL(string: "https://support.giphy.com/hc/en-us/articles/360020027752-GIPHY-User-Terms-of-Service#:~:text=Please%20do%20not%20publicly%20post,in%20connection%20with%20its%20Services.") {
            UIApplication.shared.open(url)
        }
    }
    
    
}
