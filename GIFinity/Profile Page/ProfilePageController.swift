//
//  ProfilePageController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import UIKit
import FirebaseFirestoreInternal

class ProfilePageController: UIViewController {
    @IBOutlet weak var profileBackgroundGif: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullnameLabelText: UILabel!
    
    let userUid = CurrentUserDetect.currentUser()
    let database = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        getUserInfo()
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
    
    func configUI() {
        let profileBackground = UIImage.gifImageWithName("profileBackgroundGIF")
        profileBackgroundGif.image = profileBackground
        
        let profile = UIImage.gifImageWithName("profileGIF")
        profileImage.image = profile
    }
    
    func getUserInfo() {
        let userInfoCollection = database.collection("UserInfo")
        userInfoCollection.whereField("uid", isEqualTo: userUid).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("no documents")
                return
            }
            
            for document in documents {
                let dict = document.data()
                if let data = try? JSONSerialization.data(withJSONObject: dict),
                   let item = try? JSONDecoder().decode(UserProfile.self, from: data) {
                    self.fullnameLabelText.text = item.fullname
                }
            }
        }
    }
}
