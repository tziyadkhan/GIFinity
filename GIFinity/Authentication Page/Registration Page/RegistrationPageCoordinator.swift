//
//  RegistrationPageCoordinator.swift
//  GIFinity
//
//  Created by Ziyadkhan on 01.03.24.
//

import Foundation
import UIKit

class RegistrationPageCoordinator {
    var navigationController: UINavigationController
    var onLogin: ((String, String) -> Void)?

    init(navigationController: UINavigationController, onLogin: ((String, String) -> Void)?) {
        self.navigationController = navigationController
        self.onLogin = onLogin

    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(RegistrationPageController.self)") as! RegistrationPageController
        controller.onLogin = onLogin
        navigationController.show(controller, sender: nil)
    }
    
    
}
