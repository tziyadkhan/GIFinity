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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(RegistrationPageController.self)") as! RegistrationPageController
        controller.onLogin = { email, password in

        }
        navigationController.show(controller, sender: nil)
    }

}
