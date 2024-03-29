//
//  OnBoardController.swift
//  GIFinity
//
//  Created by Ziyadkhan on 06.01.24.
//

import UIKit

class OnBoardController: UIViewController {
    
    @IBOutlet weak var centralGIF: UIImageView!
    @IBOutlet weak var backgroundGIF: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       configUI()
    }
    
    @IBAction func getStartedButton(_ sender: Any) {
        showAuthPage()
        setRoot()
    }
}

//MARK: Functions
extension OnBoardController {
    
    func configUI() {
        let backgroundGif = UIImage.gifImageWithName("background")
        backgroundGIF.image = backgroundGif
        let centralGif = UIImage.gifImageWithName("centralGif")
        centralGIF.image = centralGif
        
    }
    
    func setRoot() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate {
            UserDefaults.standard.set(true, forKey: "getStarted")
            sceneDelegate.loginPage(window: scene)
        }
    }
    
    func showAuthPage() {
        let coordinator = LoginPageCoordinator(navigationController: navigationController ?? UINavigationController())
        coordinator.start()
    }
}
