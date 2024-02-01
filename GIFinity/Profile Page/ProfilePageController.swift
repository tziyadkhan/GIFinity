//
//  ProfilePageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import UIKit

class ProfilePageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exit(_ sender: Any) {
        showAlert(title: "Warning", message: "Are you sure you want to exit?")
    }
}

extension ProfilePageController {
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(false, forKey: "loggedIN") // Setting the flag
            sceneDelegate.loginPage(window: scene)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okaybutton = UIAlertAction(title: "Log out", style: .default) { (_) in
            self.setRoot()
        }
        let cancelButton = UIAlertAction(title: "Stay", style: .cancel)
        
        alertController.addAction(okaybutton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
}
