//
//  LoginPageCoordinator.swift
//  GIFinity
//
//  Created by Ziyadkhan on 01.03.24.
//

import UIKit

class LoginPageCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(LoginPageController.self)") as! LoginPageController
        navigationController.show(controller, sender: nil)
    }
}
