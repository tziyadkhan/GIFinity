//
//  SettingsPageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 14.02.24.
//

import UIKit

class SettingsPageController: UIViewController {
    
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var background: UIImageView!
    
    private let urlHelper = URLs()
    private let viewmodel = SettingsPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        configViewModel()
    }
    
    @IBAction func supportButtonTapped(_ sender: Any) {
        urlHelper.gifinitySupport()
    }
    
    
    @IBAction func privacySafetyButtonTapped(_ sender: Any) {
        urlHelper.privacyTerms()
    }
    
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        showAlert(title: "Warning", message: "Are you sure you want to exit?")
        
    }
    
}

extension SettingsPageController {
    
    func configUI() {
        let backgroundGIF = UIImage.gifImageWithName("settings")
        background.image = backgroundGIF
        
        title = "Settings"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.setValue(false, forKey: "loggedIN") // Setting the flag
            sceneDelegate.loginPage(window: scene)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let logoutbutton = UIAlertAction(title: "Log out", style: .default) { (_) in
            self.setRoot()
        }
        let cancelButton = UIAlertAction(title: "Stay", style: .cancel)
        
        alertController.addAction(logoutbutton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    func configViewModel() {
        viewmodel.successFullname = { fullname in
            self.fullnameLabel.text = fullname
        }
        viewmodel.getUserInfo()
    }
}
